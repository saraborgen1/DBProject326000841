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

---

### שיטה 2: GenerateData  
שימש ליצירת נתונים עבור:
- Compets  
- NationalTeam  

קבצים לדוגמה:  
- [Competsgeneratedata.csv](שלב%20א/generatedataFiles/Competsgeneratedata.csv)  
- [nationalteamgenerateData.csv](שלב%20א/generatedataFiles/nationalteamgenerateData.csv)

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

תהליך גיבוי הנתונים בוצע באמצעות pgAdmin ליצוא קובץ .sql  
שחזור הנתונים בוצע באמצעות ייבוא הקובץ חזרה ל־pgAdmin.

צרף צילומי מסך מתאימים לתיקייה screenshots:
- backup.png  
- restore.png

</div>

