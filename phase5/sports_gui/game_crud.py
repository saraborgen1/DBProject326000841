import tkinter as tk
from tkinter import messagebox, ttk
import ttkbootstrap as tb
from db_config import get_connection


def open_game_screen():
    """חלון CRUD לטבלת game (עבור העמודות: gameid, gamedate, gamelocation, tournamentid)"""
    # ---------------- פונקציות עזר ---------------- #
    def refresh_data():
        """טוען מחדש את המשחקים מתוך ה‑DB אל ה‑Treeview"""
        tree.delete(*tree.get_children())
        try:
            with get_connection() as conn:
                with conn.cursor() as cur:
                    cur.execute(
                        "SELECT gameid, gamedate, gamelocation, tournamentid FROM game ORDER BY gameid"
                    )
                    for row in cur.fetchall():
                        tree.insert("", tk.END, values=row)
        except Exception as err:
            messagebox.showerror("Error", str(err))

    def add_game():
        try:
            with get_connection() as conn:
                with conn.cursor() as cur:
                    cur.execute(
                        """
                        INSERT INTO game (gameid, gamedate, gamelocation, tournamentid)
                        VALUES (%s, %s, %s, %s)
                        """,
                        (
                            ent_id.get(),
                            ent_date.get(),
                            ent_loc.get(),
                            ent_tour.get(),
                        ),
                    )
                    conn.commit()
            refresh_data()
        except Exception as err:
            messagebox.showerror("Error", str(err))

    def update_game():
        try:
            with get_connection() as conn:
                with conn.cursor() as cur:
                    cur.execute(
                        """
                        UPDATE game SET
                            gamedate     = %s,
                            gamelocation = %s,
                            tournamentid = %s
                        WHERE gameid = %s
                        """,
                        (
                            ent_date.get(),
                            ent_loc.get(),
                            ent_tour.get(),
                            ent_id.get(),
                        ),
                    )
                    conn.commit()
            refresh_data()
        except Exception as err:
            messagebox.showerror("Error", str(err))

    def delete_game():
        try:
            with get_connection() as conn:
                with conn.cursor() as cur:
                    cur.execute("DELETE FROM game WHERE gameid = %s", (ent_id.get(),))
                    conn.commit()
            refresh_data()
        except Exception as err:
            messagebox.showerror("Error", str(err))

    def fill_fields(event):
        selected = tree.focus()
        if not selected:
            return
        vals = tree.item(selected, "values")
        for ent, val in zip((ent_id, ent_date, ent_loc, ent_tour), vals):
            ent.delete(0, tk.END)
            ent.insert(0, val)

    # ---------------- GUI ---------------- #
    win = tb.Toplevel()
    win.title("🏟️ Game Management")
    win.geometry("800x480")

    # Treeview להצגת המשחקים
    columns = ("gameid", "gamedate", "gamelocation", "tournamentid")
    tree = ttk.Treeview(win, columns=columns, show="headings", height=12)
    for col in columns:
        tree.heading(col, text=col)
        tree.column(col, width=180, anchor=tk.CENTER)
    tree.pack(pady=10, padx=10, fill=tk.X)
    tree.bind("<ButtonRelease-1>", fill_fields)

    # טופס קלט
    form = tb.Frame(win)
    form.pack(pady=5)

    labels = ("ID", "Date (YYYY-MM-DD)", "Location", "Tournament ID")
    entries = []
    for idx, lbl in enumerate(labels):
        tb.Label(form, text=lbl).grid(row=0, column=idx, padx=5, pady=2)
        ent = tb.Entry(form, width=20)
        ent.grid(row=1, column=idx, padx=5, pady=2)
        entries.append(ent)

    ent_id, ent_date, ent_loc, ent_tour = entries

    # כפתורים
    btns = tb.Frame(win)
    btns.pack(pady=10)

    tb.Button(btns, text="Add", bootstyle="success", width=12, command=add_game).pack(side=tk.LEFT, padx=5)
    tb.Button(btns, text="Update", bootstyle="warning", width=12, command=update_game).pack(side=tk.LEFT, padx=5)
    tb.Button(btns, text="Delete", bootstyle="danger", width=12, command=delete_game).pack(side=tk.LEFT, padx=5)
    tb.Button(btns, text="Refresh", bootstyle="info", width=12, command=refresh_data).pack(side=tk.LEFT, padx=5)

    refresh_data()


# הרצה ישירה לצורכי בדיקה
if __name__ == "__main__":
    open_game_screen()
