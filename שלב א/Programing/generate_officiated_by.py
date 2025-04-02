import random

# Set number of records
num_records = 300

# Generate random GameIDs and RefereeIDs
game_ids = random.sample(range(101, 401), num_records)  # Assuming GameID range
referee_ids = [random.randint(1, 300) for _ in range(num_records)]  # Assuming RefereeID range

# Combine into (GameID, RefereeID) pairs
officiated_by_data = list(zip(game_ids, referee_ids))

# Generate SQL insert statement
insert_lines = [
    "INSERT INTO Officiated_By (GameID, RefereeID) VALUES"
]
values = [f"({gid}, {rid})" for gid, rid in officiated_by_data]
insert_lines.append(",\n".join(values) + ";")

# Write to file
with open("insert_officiated_by.sql", "w", encoding="utf-8") as f:
    f.write("\n".join(insert_lines))
