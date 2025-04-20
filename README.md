<div dir="rtl" style="font-family: David; font-size: 14pt;">

# מערכת ניהול טורניר כדורסל בין נבחרות  
מגישה: שרה בורגן  
היחידה הנבחרת: טורניר לאומי

---

## תוכן עניינים  
- [מבוא](#מבוא)  
- [ERD – תרשים ישויות וקשרים](#erd--תרשים-ישויות-וקשרים)  
- [DSD – תרשים מבנה נתונים](#dsd--תרשים-מבנה-נתונים)  
- [החלטות עיצוב](#החלטות-עיצוב)  
- [שיטות הכנסת נתונים](#שיטות-הכנסת-נתונים)  
  - [שיטה 1: Mockaroo](#שיטה-1-mockaroo)  
  - [שיטה 2: GenerateData](#שיטה-2-generatedata)  
  - [שיטה 3: Python Script](#שיטה-3-python-script)  
- [גיבוי ושחזור](#גיבוי-ושחזור)
- [שלב ב – שאילתות ועדכונים](#שלב-ב--שאילתות-ועדכונים)
  - [שאילתות SELECT](#שאילתות-select)
  - [שאילתות UPDATE](#שאילתות-update)
  - [שאילתות DELETE](#שאילתות-delete)


---

## מבוא

מסד הנתונים של טורניר הכדורסל בין נבחרות לאומיות נבנה כדי לעזור לנהל בצורה מסודרת את כל מה שקשור לטורניר: קבוצות, שחקנים, מאמנים, שופטים, משחקים וטורנירים שמתקיימים כל שנה.

המערכת מאפשרת לשמור ולעקוב אחרי כל הפרטים שצריך – כמו מי שיחק מול מי, איזה שופט שפט איזה משחק, כמה נקודות כל קבוצה קיבלה, מי המאמן של כל קבוצה, ועוד.

### מטרת מסד הנתונים

המערכת נועדה לאפשר:

- רישום של קבוצות (נבחרות לאומיות) עם שם, מדינה, צבע מדים ומאמן.
- תיעוד של טורנירים לפי שנה ומדינה מארחת.
- יצירת משחקים כחלק מהטורניר.
- שיבוץ שופטים לכל משחק.
- שמירת תוצאה של כל קבוצה בכל משחק.
- תיעוד של שחקנים – כולל שם, תאריך לידה, גובה, תפקיד בקבוצה ומספר חולצה.

### שימושים אפשריים

- מנהלי הטורניר יכולים לתכנן בקלות את הטורניר, לנהל את הקבוצות, לקבוע משחקים ולשבץ שופטים.
- מאמנים יכולים לראות מי נמצא בקבוצה שלהם, לעקוב אחרי משחקים ולנתח תוצאות.
- שופטים משובצים למשחקים לפי הצורך, והמערכת שומרת את המידע הזה.
- סטודנטים או מנהלי מידע יכולים לשלוף מידע וסטטיסטיקות על קבוצות, שחקנים וטורנירים.

### למה זה חשוב

מסד הנתונים עוזר לעשות סדר בכל המידע שקשור לטורניר. הוא שומר על דיוק, מאפשר שליפות מהירות של מידע, ויכול בעתיד גם להתחבר לאתר או מערכת חיצונית להצגת התוצאות.

---

## ERD – תרשים ישויות וקשרים  
![image](https://github.com/user-attachments/assets/050bc705-4089-405d-9147-06625408fba9)

---

## DSD – תרשים מבנה נתונים  
![image](https://github.com/user-attachments/assets/183ad59d-af75-4ce1-b353-1cb044209343)

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
- Game  
- Referee  
- Tournament  

קבצים לדוגמה:  
- [CoachMOCK_DATA.csv](שלב%20א/mockarooFiles/CoachMOCK_DATA.csv)  
- [GameMOCK_DATA.csv](שלב%20א/mockarooFiles/GameMOCK_DATA.csv)  
- [RefereeMOCK_DATA.csv](שלב%20א/mockarooFiles/RefereeMOCK_DATA.csv)  
- [TournamentMOCK_DATA.csv](שלב%20א/mockarooFiles/TournamentMOCK_DATA.csv)

תמונה:
![צילום מסך 2025-03-30 143231](https://github.com/user-attachments/assets/1b2e22cb-872b-4d1d-9c93-6e5bb3e1bfbc)

---

### שיטה 2: GenerateData  
שימש ליצירת נתונים עבור:
- Compets  
- NationalTeam  

קבצים לדוגמה:  
- [Competsgeneratedata.csv](שלב%20א/generatedataFiles/Competsgeneratedata.csv)  
- [nationalteamgenerateData.csv](שלב%20א/generatedataFiles/nationalteamgenerateData.csv)

תמונה:
![צילום מסך 2025-03-30 150846](https://github.com/user-attachments/assets/5a9ac7d9-2398-4edb-836d-b581765dc8b6)

---

### שיטה 3: Python Script  
שימש ליצירת פקודות SQL עבור:
- Officiated_By  

קבצי קוד:  
- [generate_officiated_by.py](שלב%20א/Programing/generate_officiated_by.py)

קבצי פלט:  
- [insert_officiated_by.sql](שלב%20א/Programing/insert_officiated_by.sql)

תמונה:
![צילום מסך 2025-03-30 160021](https://github.com/user-attachments/assets/d527d12d-6b8e-44ae-bb64-c4fbc40abd49)

---

## גיבוי ושחזור

תהליך גיבוי הנתונים בוצע באמצעות pgAdmin ליצוא קובץ `.sql`:  
- [backup30_03_2025_16_05](שלב%20א/Backup/backup30_03_2025_16_05)

שחזור הנתונים בוצע באמצעות ייבוא הקובץ חזרה ל־pgAdmin.
![image](https://github.com/user-attachments/assets/354d48a0-f38f-4870-a55a-9f0919e2a098)
![image](https://github.com/user-attachments/assets/c97f5329-5dac-43e1-9546-1c5ff25a926f)
תהליך שחזור-
![image](https://github.com/user-attachments/assets/ba1fa45f-5e26-41e5-a2bf-bc7e71284cfe)
![image](https://github.com/user-attachments/assets/71c65a65-1883-4085-b01d-7e2eec6db79a)
![image](https://github.com/user-attachments/assets/424681d6-7953-4cb4-af39-1242b9fa7e58)

---
## שלב ב – שאילתות ועדכונים

### שאילתות SELECT
שאילתא 1 – שם נבחרת, כמות שחקנים ושם המאמן
<br>
שאילתא זו מציגה לכל נבחרת את המידע הבא:
שם הקבוצה (TeamName),
מספר השחקנים בקבוצה (PlayerCount),
שם המאמן (פרטי ומשפחה).
השאילתא מבצעת חיבור (JOIN) בין הטבלאות NationalTeam, Player ו־Coach, ומקבצת (GROUP BY) לפי שם הנבחרת ושם המאמן.
זוהי שאילתא שימושית להצגת תמונת מצב של הקבוצות, כמות השחקנים ומי מאמן אותן.
<br>

צילום הרצה:
![image](https://github.com/user-attachments/assets/2061c6e3-1e09-422e-b8a2-b542c49c3e85)

צילום תוצאה:
![image](https://github.com/user-attachments/assets/78e5cfbb-c896-4c13-a291-05427d3e1f8a)
<br>

שאילתא 2 – כמות משחקים וקבוצות שמשחקות בכל חודש ושנה
<br>
שאילתא זו מציגה את הפעילות של משחקים לפי זמן – לכל שנה וחודש:
השנה שבה התקיימו המשחקים (Year),
החודש בתוך אותה שנה (Month),
מספר המשחקים השונים שנערכו (NumOfGames),
מספר הקבוצות השונות שהשתתפו באותם משחקים (NumOfTeams).
השאילתא מבצעת חיבור (JOIN) בין טבלת Game לטבלת Compets, משתמשת ב־EXTRACT כדי לחלץ את השנה והחודש מתוך התאריך, ומקבצת (GROUP BY) לפי שנה וחודש.
מטרת השאילתא היא לנתח פעילות חודשית של טורנירים – כמה משחקים התקיימו וכמה קבוצות השתתפו.
<br>

צילום הרצה:
![image](https://github.com/user-attachments/assets/dc5b505d-a8c1-469f-93bd-2bec70f981a8)

צילום תוצאה:
![image](https://github.com/user-attachments/assets/59223401-48c2-4316-b300-3e8837829387)







### שאילתות UPDATE
(כאן 3 שאילתות העדכון)

### שאילתות DELETE
(כאן 3 שאילתות המחיקה)







</div>

