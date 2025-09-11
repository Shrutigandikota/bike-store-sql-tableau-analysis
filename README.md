# Bikestore SQL & Tableau Analysis
SQL + Tableau project analyzing the **Bikestore Dataset**

## Project Overview
This project explores the **Bikestore Dataset** to uncover insights focusing on sales trends, customer behaviour, product performance and store efficiency. It combines **SQL** for data modelling, cleaning and advanced analytics with **Tableau** for interactive visualizations.
- **SQL Scripts**: Build the database schema and generate key metrics such as total sales, average order value, top customers, brand performance, stock levels, shipping efficiency and staff contributions.
- **Tableau dashboard**: Visualize these metrics through dashboards:
  1. **Sales Overview Dashboard**: Highlights overall sales performance, product category trends and monthly sales distribution.
  2. **Customer Insights Dashboard**: Shows customer KPIs, new vs returning customers, state-wise distribution, top customers, brand preferences, customer count across sales bins and monthly active customers.

## Dataset
- Downloaded from [Kaggle](https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database/data)
- Originally provided by [SQLServerTutorial.net](https://www.sqlservertutorial.net/getting-started/sql-server-sample-database/)

## Tableau Data Source
Both dashboards use a single data source, created by joining multiple tables from the bikestore SQL database. The key relationships in the data source are:
 - customers &#8594; orders &#8594; order_items &#8594; products
 - products &#8594; brands
 - products &#8594; categories

The data source is included as an extract in the .twbx file, so users can interact with the dashboards without connecting to SQL Server database. 

## Usage

### SQL Setup
1. Download the bikestore dataset from Kaggle.
2. Run the [bikestore_data.sql](sql_scripts/bikestore_data.sql) script to create database and tables in SQL Server. 
3. Import the dataset into the corresponding tables.
4. Execute the remaining SQL scripts to generate insights.

### Tableau Setup
1. Download and open 'Bikestore Sales and Customer Insights.twbx' in Tableau Desktop.
2. Interact with visuals to explore insights.
