import tkinter as tk
from tkinter import messagebox
from tkinter import ttk
import ttkbootstrap as tb
from db_config import get_connection

def open_team_screen():
    def refresh_data():
        for row in tree.get_children():
            tree.delete(row)
        cur = conn.cursor()
        cur.execute("SELECT * FROM nationalteam ORDER BY teamid")
        for row in cur.fetchall():
            tree.insert("", "end", values=row)
        cur.close()

    def add_team():
        try:
            cur = conn.cursor()
            cur.execute("""
                INSERT INTO nationalteam (teamid, teamname, teamcountry, uniformcolor, fiba_ranking, coachid, team_group, sporttype)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """, (
                entry_id.get(),
                entry_name.get(),
                entry_country.get(),
                entry_color.get(),
                entry_rank.get(),
                entry_coach.get(),
                entry_group.get(),
                entry_sport.get()
            ))
            conn.commit()
            cur.close()
            refresh_data()
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def delete_team():
        try:
            cur = conn.cursor()
            cur.execute("DELETE FROM nationalteam WHERE teamid = %s", (entry_id.get(),))
            conn.commit()
            cur.close()
            refresh_data()
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def update_team():
        try:
            cur = conn.cursor()
            cur.execute("""
                UPDATE nationalteam SET 
                    teamname = %s,
                    teamcountry = %s,
                    uniformcolor = %s,
                    fiba_ranking = %s,
                    coachid = %s,
                    team_group = %s,
                    sporttype = %s
                WHERE teamid = %s
            """, (
                entry_name.get(),
                entry_country.get(),
                entry_color.get(),
                entry_rank.get(),
                entry_coach.get(),
                entry_group.get(),
                entry_sport.get(),
                entry_id.get()
            ))
            conn.commit()
            cur.close()
            refresh_data()
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def fill_fields(event):
        selected = tree.focus()
        if not selected:
            return
        values = tree.item(selected, 'values')
        entry_id.delete(0, tk.END)
        entry_id.insert(0, values[0])
        entry_name.delete(0, tk.END)
        entry_name.insert(0, values[1])
        entry_country.delete(0, tk.END)
        entry_country.insert(0, values[2])
        entry_color.delete(0, tk.END)
        entry_color.insert(0, values[3])
        entry_rank.delete(0, tk.END)
        entry_rank.insert(0, values[4])
        entry_coach.delete(0, tk.END)
        entry_coach.insert(0, values[5])
        entry_group.delete(0, tk.END)
        entry_group.insert(0, values[6])
        entry_sport.delete(0, tk.END)
        entry_sport.insert(0, values[7])

    # GUI setup
    team_win = tb.Toplevel()
    team_win.title("Manage National Teams")
    team_win.geometry("1100x500")

    conn = get_connection()

    columns = ("teamid", "teamname", "teamcountry", "uniformcolor", "fiba_ranking", "coachid", "team_group", "sporttype")
    tree = ttk.Treeview(team_win, columns=columns, show="headings")
    for col in columns:
        tree.heading(col, text=col)
        tree.column(col, width=130)
    tree.pack(pady=10)
    tree.bind("<ButtonRelease-1>", fill_fields)

    # Entry fields
    frame = tb.Frame(team_win)
    frame.pack()

    entry_id = tb.Entry(frame, width=10)
    entry_name = tb.Entry(frame, width=15)
    entry_country = tb.Entry(frame, width=15)
    entry_color = tb.Entry(frame, width=15)
    entry_rank = tb.Entry(frame, width=10)
    entry_coach = tb.Entry(frame, width=10)
    entry_group = tb.Entry(frame, width=10)
    entry_sport = tb.Entry(frame, width=10)

    entry_id.grid(row=0, column=0, padx=5, pady=5)
    entry_name.grid(row=0, column=1, padx=5)
    entry_country.grid(row=0, column=2, padx=5)
    entry_color.grid(row=0, column=3, padx=5)
    entry_rank.grid(row=0, column=4, padx=5)
    entry_coach.grid(row=0, column=5, padx=5)
    entry_group.grid(row=0, column=6, padx=5)
    entry_sport.grid(row=0, column=7, padx=5)

    # Action buttons
    tb.Button(team_win, text="Add", command=add_team, bootstyle="success").pack(pady=5)
    tb.Button(team_win, text="Update", command=update_team, bootstyle="warning").pack(pady=5)
    tb.Button(team_win, text="Delete", command=delete_team, bootstyle="danger").pack(pady=5)

    refresh_data()
