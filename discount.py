
import tkinter.messagebox
import tkinter as tk  # 使用Tkinter前需要先导入
from database import *

def open(points,member_id):
    # 第1步，实例化object，建立窗口window
    window = tk.Toplevel()
    # 第2步，给窗口的可视化起名字
    window.title('统计系统')
    # 第3步，设定窗口的大小(长 * 宽)
    window.geometry('300x800')  # 这里的乘是小x

    # 优惠
    label_discount = tk.Label(window, bg='yellow', width=30, text ="选择优惠")
    label_discount.pack()


    # 存放统计结果
    discount = db_get_discountlist()
    print(discount)
    listbox = tk.Listbox(window, listvariable=discount)
    for discount_item in discount:
        if points < discount[discount_item][1]: # 积分不够规则所需
            continue
        off_price = str(discount[discount_item][0])
        require_points = str(discount[discount_item][1])
        listbox.insert("end","花费"+require_points+"积分获得"+off_price+"元优惠" )
    listbox.pack()

    def commit_discount():
        if listbox.curselection() == ():
            tkinter.messagebox.showinfo(title='警告', message='请点击框内优惠才提交')
            return
        db_commit_discount(discount[listbox.curselection()[0]+1][1],member_id)
        cancle()

    def cancle():
        window.destroy()
        tkinter.messagebox.showinfo(title='结账', message='结账成功，欢迎下次再来！')

    # 确认优惠
    button_commit = tk.Button(window, text='使用', width=15, height=2, command=commit_discount)
    button_commit.pack()
    button_cancel = tk.Button(window, text='不使用', width=15, height=2, command=cancle)
    button_cancel.pack()

    window.mainloop()