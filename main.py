
def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        pass

    try:
        import unicodedata
        unicodedata.numeric(s)
        return True
    except (TypeError, ValueError):
        pass

    return False

# window
import tkinter.messagebox
import tkinter as tk  # 使用Tkinter前需要先导入
import order
import statistic
from database import *

table = db_get_table()






window_table = tk.Tk()
window_table.title('选择餐桌')
window_table.geometry('300x500')
listbox_table = tk.Listbox(window_table, listvariable = table)
for table_item in table:
    listbox_table.insert("end", table_item+" "+table[table_item][0])
listbox_table.pack()

e_member = tk.Entry(window_table, show=None, font=('Arial', 14))
e_member.insert(0,"输入会员号")
e_member.pack()

def submit_table():
    if listbox_table.curselection() == ():
        tkinter.messagebox.showinfo(title='警告', message='请点击框内餐桌再选择')
        return
    table_item = listbox_table.get(listbox_table.curselection())
    occupied = table[table_item[0:3]][0]
    if occupied=="占用":
        tkinter.messagebox.showinfo(title='警告', message='当前餐桌有人')
        return
    table_num = int(table_item[2:3])
    next_bill = db_sit(table_num)
    window_table.withdraw()
    member_id = e_member.get()
    if is_number(member_id):
        member_id = int(member_id)
    else:
        member_id = None
    order.open_order_table(table_num,next_bill,member_id)

def enter_statistic():
    # window_table.withdraw()
    statistic.open()

def close_shop():
    db_clear_table()
    table = db_get_table()
    listbox_table.delete(0,"end")
    for table_item in table:
        listbox_table.insert("end", table_item+" "+table[table_item][0])


button_select_table = tk.Button(window_table, text='选择', width=15, height=2, command=submit_table)
button_select_table.pack()
button_statistic = tk.Button(window_table, text='进入后台统计界面', width=15, height=2, command=enter_statistic)
button_statistic.pack()
button_statistic = tk.Button(window_table, text='打烊', width=15, height=2, command=close_shop)
button_statistic.pack()


# 第7步，主窗口循环显示
window_table.mainloop()