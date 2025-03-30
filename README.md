<div dir="rtl" style="font-family: David; font-size: 14pt;">

# מערכת ניהול טורניר כדורסל בין נבחרות  
מגישה: שרה בורגן  
היחידה הנבחרת: טורניר לאומי

---

## תוכן עניינים  
-- [מבוא](#מבוא)  
- [ERD – תרשים ישויות וקשרים](#erd--תרשים-ישויות-וקשרים)  
- [DSD – תרשים מבנה נתונים](#dsd--תרשים-מבנה-נתונים)  
- [החלטות עיצוב](#החלטות-עיצוב)  
- [שיטות הכנסת נתונים](#שיטות-הכנסת-נתונים)  
  - [שיטה 1: Mockaroo](#שיטה-1-mockaroo)  
  - [שיטה 2: GenerateData](#שיטה-2-generatedata)  
  - [שיטה 3: Python Script](#שיטה-3-python-script)  
- [גיבוי ושחזור](#גיבוי-ושחזור)


---

## מבוא

מערכת זו נועדה לנהל טורניר כדורסל בין נבחרות לאומיות.  
המערכת שומרת מידע על קבוצות, שחקנים, מאמנים, משחקים, שופטים וטורנירים.

המערכת כוללת פונקציונליות לניהול תוצאות משחקים, שיוך קבוצות לטורנירים, שיבוץ שופטים, ושליפת מידע סטטיסטי.

---

## ERD – תרשים ישויות וקשרים  
צרף כאן את קובץ ה־ERD שלך (למשל: `ERD.png`)

---

## DSD – תרשים מבנה נתונים  
צרף כאן את קובץ ה־DSD שלך (למשל: `DSD.png`)

---

## החלטות עיצוב

- שימוש בטבלת Compets לקישור תוצאות משחקים עם קבוצות, משחקים וטורנירים.
- שימוש בטבלת Officiated_By עם מפתח משולב GameID + RefereeID.
- כל שחקן שייך לנבחרת אחת בלבד (TeamID).
- כל משחק שייך לטורניר אחד בלבד.

---

## שיטות הכנסת נתונים

### שיטה 1: Mockaroo  
שימש ליצירת נתונים עבור הטבלאות:
- Coach  
- Referee  
- Player  

קבצים לדוגמה:  
- coachMock_data.csv  
- refereeMock_data.csv  
- playerMock_data.csv

---

### שיטה 2: GenerateData  
שימש ליצירת נתונים עבור:
- Tournament  
- Game  
- NationalTeam  

קבצים לדוגמה:  
- tournamentGenerateData.csv  
- gameGenerateData.csv  
- nationalTeamGenerateData.csv

---

### שיטה 3: Python Script  
שימש ליצירת פקודות SQL עבור:
- Officiated_By  
- Compets  

קבצי קוד:
- generate_officiated_by.py  
- generate_compets.py  

קבצי פלט:
- insert_officiated_by.sql  
- insert_compets.sql

---

## גיבוי ושחזור

תהליך גיבוי הנתונים בוצע באמצעות pgAdmin ליצוא קובץ `.sql`.  
שחזור הנתונים בוצע באמצעות ייבוא הקובץ חזרה ל־pgAdmin.

צרף צילומי מסך מתאימים לתיקייה screenshots:
- backup.png  
- restore.png

</div>

