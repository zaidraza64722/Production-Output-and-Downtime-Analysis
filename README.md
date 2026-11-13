# Production Output & Downtime Analysis

An end-to-end Data Analytics project focused on analyzing industrial production performance, machine downtime, and operational efficiency using Python, SQL, and Power BI.

## Project Overview

This project analyzes industrial production data to identify machine-level performance issues, downtime patterns, and production losses. The objective is to understand which machines contribute most to production losses and identify opportunities for operational improvement.

## Business Questions

- Which machines experience the highest downtime?
- Which machines contribute most to total production losses?
- Which alarm codes are responsible for major downtime?
- How does operating status vary across machines?
- Where can production efficiency be improved?

## Tools & Technologies

- **Python:** Data cleaning, preprocessing and exploratory data analysis
- **Pandas & NumPy:** Data manipulation and analysis
- **Matplotlib & Seaborn:** Data visualization
- **SQL (MySQL):** Data querying and analysis
- **Power BI:** Interactive dashboard development
- **DAX:** KPI calculations and performance metrics

## Dataset Overview

- **Total Records:** 429,394
- **Machines:** 5
- **Alarm Codes:** 133
- **Data Period:** January 2020 – January 2022
- **Data Source:** PIADE industrial production dataset

## Project Workflow

1. **Data Understanding** – Examined dataset structure, columns, data types and distributions.
2. **Data Cleaning** – Handled invalid records, checked missing values and duplicates, and prepared the dataset.
3. **Exploratory Data Analysis (EDA)** – Analyzed machine performance, operating status, downtime and alarm patterns.
4. **SQL Analysis** – Used SQL queries to investigate production performance and machine-level losses.
5. **Power BI Dashboard** – Developed interactive dashboards using DAX measures and visualizations.
6. **Insights & Recommendations** – Identified major contributors to production downtime and performance losses.

## Key Insights

- Machine **s_1** recorded the highest combined downtime and performance loss, approximately **2,934 hours**, accounting for around **37%** of the total loss across all five machines.
- Alarm code **A_065** contributed approximately **858 hours of downtime**, representing around **27%** of total downtime.
- Machine-level comparisons revealed significant differences in downtime and performance losses.
- Operating status analysis highlighted production, idle, downtime and performance-loss patterns.

## Power BI Dashboard

The dashboard provides an overview of production performance, machine-level comparisons, downtime analysis and operational losses.

*Add your Power BI dashboard screenshots here.*

## Project Structure

```text
Production-Output-Downtime-Analysis/
│
├── Dataset/
│   ├── Raw/
│   └── Cleaned/
│
├── Python/
│   ├── 01_Data_Understanding.ipynb
│   └── 02_EDA_Analysis.ipynb
│
├── SQL/
│   └── Production_Output_Downtime_Analysis.sql
│
├── PowerBI/
│   └── Dashboard.pbix
│
└── README.md
```

## How to Run the Project

1. Clone this repository:

   ```bash
   git clone https://github.com/zaidraza64722/Production-Output-Downtime-Analysis.git
   ```

2. Install the required Python libraries:

   ```bash
   pip install pandas numpy matplotlib seaborn jupyter
   ```

3. Open the Python notebooks:

   ```bash
   jupyter notebook
   ```

4. Execute the notebooks in sequence.
5. Import the cleaned dataset into MySQL for SQL analysis.
6. Open the Power BI dashboard using Power BI Desktop.

## Project Outcome

This project demonstrates an end-to-end data analytics workflow, from raw data understanding and preprocessing to SQL analysis, visualization and business insight generation.

## Author

**Mohammed Zaid**

- GitHub: [zaidraza64722](https://github.com/zaidraza64722)
- LinkedIn: [Mohammed Zaid](https://www.linkedin.com/in/mohammedzaid17/)

---

*If you find this project useful, feel free to explore the repository!*
