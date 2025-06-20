import tkinter as tk
from tkinter import ttk, messagebox
import ttkbootstrap as tb
from db_config import get_connection

def open_query_screen():
    conn = get_connection()

    def run_query_1():
        try:
            cur = conn.cursor()
            cur.execute("""
                SELECT teamname, COUNT(*) AS num_players
                FROM player
                JOIN nationalteam  USING (teamid)
                GROUP BY teamname
                ORDER BY num_players DESC
            """)
            rows = cur.fetchall()
            update_tree(["Team", "Number of Players"], rows)
            cur.close()
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def run_query_2():
        try:
            cur = conn.cursor()
            cur.execute("""
                SELECT 
                    P.PlayerID,
                    P.PlayerFirstName,
                    P.PlayerLastName,
                    N.TeamName,
                    P.PlayerPosition
                FROM Player P
                JOIN NationalTeam N ON P.TeamID = N.TeamID
                ORDER BY P.PlayerPosition ASC, P.PlayerLastName ASC
            """)
            rows = cur.fetchall()
            update_tree(["Player ID", "First Name", "Last Name", "Team", "Position"], rows)
            cur.close()
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def run_function():
        try:
            cur = conn.cursor()
            cur.execute("SELECT * FROM get_all_players_points()")
            rows = cur.fetchall()
            update_tree(["Player ID", "Total Points"], rows)
            cur.close()
        except Exception as e:
            messagebox.showerror("Error", str(e))

    def run_procedure():
        try:
            cur = conn.cursor()
            cur.execute("CALL increase_experience_of_coaches()")
            conn.commit()
            messagebox.showinfo("Procedure Executed", "increase_experience_of_coaches executed successfully.")
            cur.close()
        except Exception as e:
            conn.rollback()
            messagebox.showerror("Error", str(e))

    def update_tree(columns, data):
        tree.delete(*tree.get_children())
        tree["columns"] = columns
        tree["show"] = "headings"
        for col in columns:
            tree.heading(col, text=col)
            tree.column(col, width=150)
        for row in data:
            tree.insert("", "end", values=row)

    win = tb.Toplevel()
    win.title("Queries & Procedures")
    win.geometry("800x500")

    frame = tb.Frame(win)
    frame.pack(pady=10)

    tb.Button(frame, text="Query: Player Count per Team", command=run_query_1, bootstyle="info").grid(row=0, column=0, padx=5)
    tb.Button(frame, text="Query: Upcoming Games", command=run_query_2, bootstyle="info").grid(row=0, column=1, padx=5)
    tb.Button(frame, text="Function: Total Points", command=run_function, bootstyle="success").grid(row=1, column=0, padx=5, pady=5)
    tb.Button(frame, text="Procedure: Auto Close Empty", command=run_procedure, bootstyle="danger").grid(row=1, column=1, padx=5, pady=5)

    tree = ttk.Treeview(win)
    tree.pack(pady=10, fill="both", expand=True)

