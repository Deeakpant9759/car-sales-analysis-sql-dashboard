# Car Sales Analysis (1998–2015) — SQL + Dashboard Project

## 📌 Project Overview
This project analyzes used car sales data from 1998 to 2015 to uncover key trends and insights.  
It focuses on building a **clean data pipeline** using SQL and creating an interactive dashboard to visualize the results.

👉 The work covers:
- Cleaning messy raw data (VIN, SALEDATE, makes, etc.)
- Handling duplicates and missing values carefully
- Standardizing text fields (make, model, color)
- Creating a dashboard with KPIs, charts, and map visualizations

---

## 💻 Tools Used
- **SQL Server** — Data cleaning, deduplication, filling missing values
- **Tableau** — Dashboard design and data storytelling
- **GitHub** — Version control and project sharing

---

## 🛠️ Key Challenges Faced
Like any real-world dataset, this one came with its own set of challenges:
- **Messy `SALEDATE` values:** The dates were stored as long text strings (with extra tags like `GMT`), and converting them to proper datetime format required substring logic and testing.
- **Duplicate records:** Identifying and safely removing duplicate rows based on `VIN` and `SALEDATE` took careful SQL work to avoid deleting valid records.
- **Missing and inconsistent values:** Fields like `make`, `model`, `MMR`, and `selling price` were sometimes missing or inconsistent. I used model-year averages to fill some gaps and filtered out unusable rows.
- **Standardizing makes:** The `make` field had many variations (e.g., `CHEV TRUCK`, `VW`, `MERCEDES-B`) that needed mapping to standard names without introducing errors.
- **Designing an effective dashboard:** With over 15 years of data, I had to balance detail with clarity to make the visualizations meaningful and easy to read.

---

## 📊 Key Insights
- 💰 **Total sales:** $6.55B (1998–2015) with a YoY growth of 78.95%.
- 🚗 **Average price:** $2.63K with YoY growth of 22.52%.
- 🏆 **Top seller:** Ford emerged as the highest-selling brand.
- 🌍 **Regional variation:** Sales varied significantly across regions and colors, as shown in the map and color distribution.

---

## 📂 Repository Contents
# car-sales-analysis-sql-dashboard
Car sales data pipeline: SQL cleaning, deduplication, and visualization

---

## ⚡ How to Run
1️⃣ Run the SQL scripts to clean and process the data in SQL Server.  
2️⃣ Open the dashboard file (`.twbx` for Tableau ) to explore the visualizations.  

---

## 🙌 What I Learned
This project taught me:
- How to plan and execute a complete data pipeline — from raw data to insights.
- How to clean messy real-world data using SQL.
- How to build dashboards that tell a clear and compelling data story.

---

## 📌 Future Enhancements
- Explore predictive modeling for pricing or sales forecasting.
- Automate the data pipeline for faster updates.
- Add interactive filters to the dashboard for deeper user exploration.

---

## ✉️ Contact
Feel free to connect or provide feedback!
Gmail:deepakpant9759@gmail.com


