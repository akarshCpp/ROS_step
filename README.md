# 🍽️ Restaurant Operations System (ROS) – End-to-End Data Engineering Project

An end-to-end Restaurant Operations System (ROS) built as part of the TalenciaGlobal Data Engineering Series. The project simulates a real-world restaurant ecosystem by designing, cleaning, transforming, generating, storing, and processing operational data across multiple interconnected modules.

## 🚀 Project Overview

This project covers the complete data lifecycle:

- Data Cleaning and Quality Checks
- Data Transformation
- Synthetic Transaction Data Generation
- Entity Relationship (ER) Modeling
- Database Design and DDL Creation
- Data Import and Validation
- KNIME Workflow Logic Design
- Preparation for Workflow Automation and Analytics

---

## 📂 Core Modules

### Master Data
- Clients
- Restaurants
- Users
- Roles
- Departments
- Subscriptions
- Countries
- Currencies
- Tax Information

### Transactional Data
- Orders
- Sales
- Expenses
- CashUp
- Banking
- Deliveries

---

## 🔄 Business Workflows

The system models five core operational processes:

1. Customer places an order.
2. Delivery partners deliver the order.
3. CashUp is published to the finance team.
4. CashUp amount is deposited by the designated employee.
5. Clients purchase subscriptions and activate restaurants.

---

## 🛠 Technologies Used

- Python
- Pandas
- NumPy
- MySQL
- SQL
- MySQL Workbench
- KNIME Analytics Platform
- DrawDB / ER Diagram Tools
- Excel

---


## 🏗 Database Design

The relational schema consists of 15 tables with fully enforced primary and foreign key relationships.

Key entities include:

- subscription
- country
- currency
- taxinfo
- client
- restaurant
- role
- department
- system_user
- orders
- sales
- expenses
- cashup
- banking
- deliveries

---


