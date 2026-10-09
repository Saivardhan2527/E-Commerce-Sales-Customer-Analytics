# E-Commerce Sales & Customer Analytics

## Project Overview
An end-to-end data analytics project that analyzes e-commerce transactions, customer purchasing behavior, product performance, customer reviews, and regional sales. The project uses Python, SQL, Excel, and Power BI to transform raw data into actionable business insights.

## Dataset
- 100,000 order transaction records
- 12,000 registered customers
- 500 products
- 45,000 customer reviews

*Note: The dataset is synthetic and used for portfolio and analytical practice.*

## Tools & Technologies
- **Excel:** Data inspection, cleaning, formulas, PivotTables, and RFM analysis
- **Python:** Pandas, NumPy, Matplotlib, Seaborn, and exploratory data analysis
- **PostgreSQL:** Data querying, joins, aggregations, CTEs, subqueries, and monthly trend analysis
- **Power BI:** Interactive dashboards and DAX measures
- **RFM Analysis:** Customer segmentation using Recency, Frequency, and Monetary value

## Key Performance Indicators
- Total revenue
- Total profit and profit margin
- Total orders and active customers
- Average order value
- Repeat customer rate
- Revenue and profit by category and region

## Power BI Dashboard Pages
1. **Executive Overview:** Revenue, profit, orders, monthly trends, category performance, regional performance, and order status.
2. **Customer Analytics:** Customer retention, purchase frequency, RFM segments, top customers, and segment revenue.
3. **Product & Sales Analytics:** Top products, category profitability, ratings, review volume, payment methods, and order status.

## Key Findings
- Generated approximately ₹3.24 billion in revenue and ₹820.7 million in profit in the dataset.
- Electronics was the highest-revenue category, followed by Fashion.
- The South region recorded the highest profit among the five regions.
- RFM analysis segmented customers into High Value, Medium Value, Low Value, and At Risk groups.
- The observed repeat customer rate was approximately 99.81%; this unusually high figure should be interpreted in the context of the synthetic dataset.

## Business Recommendations
- Investigate product-level margins to prioritize profitable products, not just high-revenue products.
- Develop retention strategies for high-value customers.
- Test targeted reactivation campaigns for at-risk customers.
- Compare customer ratings with sales and review volumes to identify potential product-quality issues.
- Monitor monthly revenue and regional performance to identify changes that warrant further investigation.

## Project Structure
- `data/` — Dataset files
- `notebooks/` — Python EDA and analysis
- `sql/` — PostgreSQL queries
- `powerbi/` — Power BI report
- `screenshots/` — Dashboard screenshots

## Outcome
Built a complete analytics workflow connecting data preparation, SQL analysis, Python EDA, RFM segmentation, KPI development, and interactive business intelligence reporting.
