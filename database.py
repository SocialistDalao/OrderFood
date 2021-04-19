import datetime

import pymysql

def db_get_table():
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    sql = """select id_table, id_server, id_bill
                from tables"""
    try:
        # 执行sql语句
        tables={}
        cursor.execute(sql)
        results = cursor.fetchall()
        for row in results:
            print(row)
            occupied = row[2]
            if occupied:
               occupied = "占用"
            else:
                occupied = "空闲"
            server = row[1]
            tables["餐桌"+str(row[0])]=[occupied,server]
        db.close()
        return tables
    except:
        # 如果发生错误则回滚
        print("wrong:get_table")
        db.rollback()
        db.close()
        return {}


# 找到下一个bill的id返回，并且将其设置成当前选择的table的bill，表示入座
def db_sit(table_num):
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    sql = """select max(id_bill)
                    from bills"""

    try:
        # 执行sql语句
        max = 0
        cursor.execute(sql)
        results = cursor.fetchall()
        for row in results:
            max = row[0]
        sql2 = """insert into bills(id_bill,id_table,id_member,time_order,money)
                    values(%d,%d,NULL,"%s",0)"""% \
               (max+1,table_num,datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
        cursor.execute(sql2)
        sql3 = """update tables
                set id_bill=%d
                where id_table = %d
                """ % \
               (max+1,table_num)
        cursor.execute(sql3)
        db.commit()
        db.close()
        return max+1
    except:
        # 如果发生错误则回滚
        print("wrong:db_sit")
        db.rollback()
        db.close()
        return 0


def db_get_server_id(table_id):
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    sql = """select id_server
                    from tables
                    where id_table = %d"""%(table_id)
    print(sql)
    try:
        # 执行sql语句
        server_id = 0
        cursor.execute(sql)
        results = cursor.fetchall()
        for row in results:
            server_id = row[0]
        db.close()
        return server_id
    except:
        # 如果发生错误则回滚
        print("wrong:db_get_server_id")
        db.rollback()
        db.close()
        return 0


def db_get_all_food():
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    food = {}
    sql = """select category from categories"""
    print(sql)
    try:
        # 执行sql语句
        cursor.execute(sql)
        results = cursor.fetchall()
        for row in results:
            food[row[0]]=[]
        sql2 = """select category, name_food, price
                    from food
                """
        cursor.execute(sql2)
        results = cursor.fetchall()
        for row in results:
            food[row[0]].append(row[1]+" "+str(row[2])+"元")
        db.close()
        return food
    except:
        # 如果发生错误则回滚
        print("wrong:db_get_all_food")
        db.rollback()
        db.close()
        return 0


def db_add_bill(bill_id,food_name):
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    food = {}
    try:
        current_money = 0
        # 执行sql语句
        sql_find_food_id = """select id_food, price 
                    from food
                    where name_food = "%s" """ %(food_name)
        cursor.execute(sql_find_food_id)
        results = cursor.fetchall()
        for row in results:
            id = row[0]
            price = row[1]
        sql_findexistsfood = """select *
                    from bill_food
                    where id_food = %d and id_bill = %d 
                    """%(id,bill_id)
        cursor.execute(sql_findexistsfood)
        if cursor.fetchall()==():
            sql2 = """insert into bill_food
                        values(%d,%d,1)
                        """%(id,bill_id)
        else:
            sql2 = """update bill_food
                        set num =num +1
                    where id_food = %d and id_bill = %d 
                                    """ % (id, bill_id)
        cursor.execute(sql2)
        sql3 = """update bills
                    set money = money+%d 
                    where id_bill = %d
                            """ % (price, bill_id)
        cursor.execute(sql3)
        db.commit()
        sql4 = """select money
                    from bills
                    where id_bill = %d
                            """ % (bill_id)
        cursor.execute(sql4)
        results = cursor.fetchall()
        for row in results:
            current_money = row[0]
            print(current_money)
            db.close()
            return current_money
    except:
        # 如果发生错误则回滚
        print("wrong:db_add_bill")
        db.rollback()
        db.close()
        return 0


def db_submit_bill(member_id,id_bill):
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    try:
        # 执行sql语句
        sql = """update tables
                set id_bill = NULL
                where id_bill = %d"""%(id_bill)
        cursor.execute(sql)
        sql2 = """update bills
                set time_pay = "%s"
                where id_bill = %d"""%(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'),id_bill)
        cursor.execute(sql2)
        if member_id != None:
            sql3 = """select money
                        from bills
                        where id_bill = %d
                                """ % (id_bill)
            cursor.execute(sql3)
            results = cursor.fetchall()
            for row in results:
                current_money = row[0]
            sql4 = """update member
                        set points = points+ %s
                        where id_member = %d""" % (current_money,member_id)
            cursor.execute(sql4)
        db.commit()
        db.close()
    except:
        # 如果发生错误则回滚
        print("wrong:db_submit_bill")
        db.rollback()
        db.close()


def db_get_sales():
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    try:
        # 执行sql语句
        sql = """SELECT name_food, sum(num)
                FROM bill_food natural join food
                group by id_food
                order by sum(num) desc"""
        cursor.execute(sql)
        results = cursor.fetchall()
        db.close()
        return results
    except:
        # 如果发生错误则回滚
        print("wrong:db_get_sales")
        db.rollback()
        db.close()
        return ()


def db_get_sales_time(start_time, end_time):
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    try:
        # 执行sql语句
        sql = """SELECT name_food, sum(num)
                FROM bill_food natural join bills natural join food
                where time_pay between "%s 00:00:00" and "%s 00:00:00"
                group by id_food
                order by sum(num) desc;"""%(start_time,end_time)
        cursor.execute(sql)
        results = cursor.fetchall()
        db.close()
        return results
    except:
        # 如果发生错误则回滚
        print("wrong:db_get_sales_time")
        db.rollback()
        db.close()
        return ()


def db_get_money_time(start_time, end_time):
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    try:
        # 执行sql语句
        sql = """SELECT sum(money)
                FROM bills
                    where time_pay between "%s 00:00:00" and "%s 00:00:00"
                    """ % (start_time, end_time)
        cursor.execute(sql)
        results = cursor.fetchall()
        for row in results:
            return row[0]
        db.close()
        return 0
    except:
        # 如果发生错误则回滚
        print("wrong:db_get_money_time")
        db.rollback()
        db.close()
        return 0

def db_clear_table():
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    try:
        # 执行sql语句
        sql = """update tables
                set id_bill = NULL
                where id_table <> 100"""
        cursor.execute(sql)
        db.commit()
        db.close()
    except:
        # 如果发生错误则回滚
        print("wrong:db_clear_table")
        db.rollback()
        db.close()


def db_get_member_point(member_id):
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    try:
        if member_id == None:
            return 0
        # 执行sql语句
        sql = """select points
                    from member
                    where id_member = %s"""%(member_id)
        cursor.execute(sql)
        results = cursor.fetchall()
        if results == ():
            sql2 = """insert into member
                    values(%s,null,0,null,null)""" % (member_id)
            cursor.execute(sql2)
            db.commit()
            db.close()
            return 0
        db.close()
        for row in results:
            return row[0]
    except:
        # 如果发生错误则回滚
        print("wrong:db_ensure_member_id")
        db.rollback()
        db.close()

def db_get_discountlist():
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    discount = {}
    sql = """select * from discounts"""
    print(sql)
    try:
        # 执行sql语句
        cursor.execute(sql)
        results = cursor.fetchall()
        for row in results:
            discount[row[0]] = [row[1],row[2]]
        db.close()
        return discount
    except:
        # 如果发生错误则回滚
        print("wrong:db_get_discountlist")
        db.rollback()
        db.close()
        return 0

def db_commit_discount(points,member_id):
    # 打开数据库连接
    db = pymysql.connect(host="localhost", user="root", password="你的密码", db="restaurant", charset="utf8")
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = db.cursor()
    discount = {}
    sql = """update member
            set points = points - %s
            where id_member = %s"""%(points,member_id)
    try:
        # 执行sql语句
        cursor.execute(sql)
        db.commit()
        db.close()
    except:
        # 如果发生错误则回滚
        print("wrong:db_commit_discount")
        db.rollback()
        db.close()
        return 0