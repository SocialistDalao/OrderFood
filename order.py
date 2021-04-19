
import tkinter.messagebox
import tkinter as tk  # 使用Tkinter前需要先导入

import discount
from database import *


food = {"川菜":["麻婆豆腐","麻辣香干"],
        "湘菜":["小炒肉"],
        "粤菜":["白切鸡","鱼子酱沙拉"],
        "甜品":["可口可乐","维维豆奶"]}
bills = []
# bill_id = 0
member_id = 3
# server_id = 7
member_cent = 0
server_id = 0
food = db_get_all_food()


def open_order_table(table_id,bill_id,member_id):
    print("member_id:"+str(member_id))
    member_point = db_get_member_point(member_id)
    server_id = db_get_server_id(table_id)
    db_get_server_id(table_id)
    # 第1步，实例化object，建立窗口window
    window = tk.Toplevel()
    # 第2步，给窗口的可视化起名字
    window.title('点餐系统')
    # 第3步，设定窗口的大小(长 * 宽)
    window.geometry('300x800')  # 这里的乘是小x
    # 第4步，在图形界面上创建一个标签label用以显示并放置
    var = tk.StringVar()  # 定义一个var用来将radiobutton的值和Label的值联系在一起.
    var.set("川菜")
    label_server = tk.Label(window, bg='yellow', width=20, text=str(server_id)+"号服务员为您服务")
    label_server.pack()
    label_food = tk.Label(window, bg='yellow', width=20, text="川菜")
    label_food.pack()
    label_order = tk.Label(window, bg='yellow', width=20, text="订单 " + "0元")
    # 对应菜品的显示
    listbox = tk.Listbox(window, listvariable=food["川菜"])
    for food_item in food[var.get()]:
        listbox.insert("end", food_item)
    listbox_bill = tk.Listbox(window, listvariable=bills)

    # 定义选项触发函数功能
    def print_category():
        print(var.get())
        label_food.config(text=var.get())
        listbox.delete(0, "end")
        for food_item in food[var.get()]:
            listbox.insert("end", food_item)

    def add_bill(food_item):
        bills.append(food_item)
        bill_money=db_add_bill(bill_id,food_item.split(' ')[0])
        listbox_bill.insert("end", food_item)
        label_order.config(text="订单 " + str(bill_money) + "元")

    def submit_bill():
        listbox_bill.delete(0, "end")
        item_num = 0
        label_order.config(text="订单 " + str(item_num) + "元")
        db_submit_bill(member_id,bill_id)
        window.destroy()
        discount.open(member_point,member_id)

    def submit_food():
        if listbox.curselection() == ():
            tkinter.messagebox.showinfo(title='警告', message='请点击框内菜品才添加')
            return
        print(listbox.curselection())
        food_item = listbox.get(listbox.curselection())
        add_bill(food_item)

        # 创建三个radiobutton选项，其中variable=var, value='A'的意思就是，当我们鼠标选中了其中一个选项，把value的值A放到变量var中，然后赋值给variable

    for category in food:
        radiobutton = tk.Radiobutton(window, text=category, variable=var, value=category, command=print_category)
        radiobutton.pack()

    listbox.pack()
    button_submit = tk.Button(window, text='添加菜品', width=15, height=2, command=submit_food)
    button_submit.pack()

    label_order.pack()
    listbox_bill.pack()
    button_pay = tk.Button(window, text='结账', width=15, height=2, command=submit_bill)
    button_pay.pack()

    # VIP
    label_member_id = tk.Label(window, width=20, text="会员号："+str(member_id))
    label_member_id.pack()
    label_server_id = tk.Label(window, width=20, text="服务员：" + str(server_id))
    label_server_id.pack()
    label_cent = tk.Label(window, width=20, text="积分：" + str(member_point))
    label_cent.pack()
    window.mainloop()