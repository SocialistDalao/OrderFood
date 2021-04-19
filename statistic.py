
import tkinter.messagebox
import tkinter as tk  # 使用Tkinter前需要先导入
from database import *

def open():
    # 第1步，实例化object，建立窗口window
    window = tk.Toplevel()
    # 第2步，给窗口的可视化起名字
    window.title('统计系统')
    # 第3步，设定窗口的大小(长 * 宽)
    window.geometry('300x800')  # 这里的乘是小x

    data = []

    # 存放统计结果
    listbox = tk.Listbox(window, listvariable=data)
    # 日期输入框
    e_start = tk.Entry(window, show=None, font=('Arial', 14))
    e_start.insert(0,"起始日期")
    e_end = tk.Entry(window, show=None, font=('Arial', 14))  # 显示成明文形式
    e_end.insert(0,"终止日期")
    label_money = tk.Label(window, width=40, text="时间段内销售总额：空（请点击查询）")

    def get_sales():
        sales = db_get_sales()
        listbox.delete(0,"end")
        for sale in sales:
            listbox.insert("end",sale[0]+" 销售量"+str(sale[1]))

    def get_sales_time():
        start_date = e_start.get()
        end_date = e_end.get()
        try:
            datetime.datetime.strptime(start_date, '%Y-%m-%d')
            datetime.datetime.strptime(end_date, '%Y-%m-%d')
        except ValueError:
            tkinter.messagebox.showinfo(title='警告', message='日期不合法，范例2021-02-03')
            return
        sales = db_get_sales_time(start_date, end_date)
        listbox.delete(0,"end")
        if sales == ():
            tkinter.messagebox.showinfo(title='提示', message='该时间段没有销售')
        for sale in sales:
            listbox.insert("end",sale[0]+" 销售量"+str(sale[1]))

    def get_money_time():
        start_date = e_start.get()
        end_date = e_end.get()
        try:
            datetime.datetime.strptime(start_date, '%Y-%m-%d')
            datetime.datetime.strptime(end_date, '%Y-%m-%d')
        except ValueError:
            tkinter.messagebox.showinfo(title='警告', message='日期不合法，范例2021-02-03')
            return
        money = db_get_money_time(start_date, end_date)
        if money == None:
            tkinter.messagebox.showinfo(title='提示', message='该时间段没有销售')
            return
        label_money.config(text = "时间段内销售总额："+str(money)+"元（点击第三个按钮刷新）")

    button_sales = tk.Button(window, text='按菜品销量排序（总）', width=20, height=2, command=get_sales)
    button_sales_time = tk.Button(window, text='按时间段销量排序', width=20, height=2, command=get_sales_time)
    button_sales_total = tk.Button(window, text='查询某时间段内销售总额', width=20, height=2, command=get_money_time)

    button_sales.pack()
    button_sales_time.pack()
    button_sales_total.pack()

    e_start.pack()
    e_end.pack()
    listbox.pack()
    label_money.pack()
    window.mainloop()