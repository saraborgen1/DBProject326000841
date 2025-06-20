import tkinter as tk
from tkinter import messagebox
from tkinter import ttk
import ttkbootstrap as tb
from db_config import get_connection

def open_player_screen():
    def refresh_data():
        for row in tree.get_children():
            tree.delete(row)
        cur = conn.cursor()
        cur.execute("SELECT * FROM player ORDER BY playerid")
        for row in cur.fetchall():
            tree.insert("", "end", values=row)
        cur.close()

    def add_player():
        try:
            cur = conn.cursor()
            cur.execute("""
                INSERT INTO player (playerid, playerfirstname, playerlastname, playerbirthdate, playerposition, teamid)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (
                entry_id.get(),
                entry_first.get(),
                entry_last.get(),
                entry_birth.get(),
                entry_pos.get(),
                entry_team.get()
            ))
            conn.commit()
            cur.close()
            refresh_data()
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def delete_player():
        try:
            cur = conn.cursor()
            cur.execute("DELETE FROM player WHERE playerid = %s", (entry_id.get(),))
            conn.commit()
            cur.close()
            refresh_data()
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def update_player():
        try:
            cur = conn.cursor()
            cur.execute("""
                UPDATE player SET 
                    playerfirstname = %s,
                    playerlastname = %s,
                    playerbirthdate = %s,
                    playerposition = %s,
                    teamid = %s
                WHERE playerid = %s
            """, (
                entry_first.get(),
                entry_last.get(),
                entry_birth.get(),
                entry_pos.get(),
                entry_team.get(),
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
        entry_first.delete(0, tk.END)
        entry_first.insert(0, values[1])
        entry_last.delete(0, tk.END)
        entry_last.insert(0, values[2])
        entry_birth.delete(0, tk.END)
        entry_birth.insert(0, values[3])
        entry_pos.delete(0, tk.END)
        entry_pos.insert(0, values[4])
        entry_team.delete(0, tk.END)
        entry_team.insert(0, values[5])

    # GUI setup
    player_win = tb.Toplevel()
    player_win.title("Manage Players")
    player_win.geometry("900x500")

    conn = get_connection()

    columns = ("playerid", "firstname", "lastname", "birthdate", "position", "teamid")
    tree = ttk.Treeview(player_win, columns=columns, show="headings")
    for col in columns:
        tree.heading(col, text=col)
        tree.column(col, width=130)
    tree.pack(pady=10)
    tree.bind("<ButtonRelease-1>", fill_fields)

    # Entry fields
    frame = tb.Frame(player_win)
    frame.pack()

    entry_id = tb.Entry(frame, width=10)
    entry_first = tb.Entry(frame, width=15)
    entry_last = tb.Entry(frame, width=15)
    entry_birth = tb.Entry(frame, width=15)
    entry_pos = tb.Entry(frame, width=10)
    entry_team = tb.Entry(frame, width=10)

    entry_id.grid(row=0, column=0, padx=5, pady=5)
    entry_first.grid(row=0, column=1, padx=5)
    entry_last.grid(row=0, column=2, padx=5)
    entry_birth.grid(row=0, column=3, padx=5)
    entry_pos.grid(row=0, column=4, padx=5)
    entry_team.grid(row=0, column=5, padx=5)

    # Action buttons
    tb.Button(player_win, text="Add", command=add_player, bootstyle="success").pack(pady=5)
    tb.Button(player_win, text="Update", command=update_player, bootstyle="warning").pack(pady=5)
    tb.Button(player_win, text="Delete", command=delete_player, bootstyle="danger").pack(pady=5)

    refresh_data()
