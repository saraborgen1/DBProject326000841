import ttkbootstrap as tb
from team_crud import open_team_screen
from player_crud import open_player_screen
from game_crud import open_game_screen
from queries_and_procedures import open_query_screen

def main_menu():
    app = tb.Window(themename="darkly")
    app.title("🎯 Sports Management")
    app.geometry("400x400")

    tb.Label(app, text="בחר מסך:", font=("Helvetica", 20)).pack(pady=30)

    tb.Button(app, text="🧍 Manage Players", width=30, command=open_player_screen).pack(pady=10)
    tb.Button(app, text="🛡 Manage Teams", width=30, command=open_team_screen).pack(pady=10)
    tb.Button(app, text="⚽ Manage Games", width=30, command=open_game_screen).pack(pady=10)
    tb.Button(app, text="📊 Queries & Procedures", width=30, command=open_query_screen).pack(pady=10)

    app.mainloop()

if __name__ == "__main__":
    main_menu()
