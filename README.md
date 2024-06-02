# **Inventory Management System for Electronics Store**

## **Project Overview**
Inventory Management System for an Electronics Store, developed using MySQL. This project aims to streamline and optimize inventory management processes, ensuring efficient handling of products, orders, customer interactions, and sales data. 

## **Project Features**

1. **Entity Relationship Diagram (ERD)**
   - We began by outlining the business requirements for our electronics store, identifying key entities such as branches, products, customer accounts, orders, and more.
   - Created an ERD to visualize the relationships between these entities, providing a clear blueprint for database structure.

2. **Database Schema**
   - Designed and implemented a robust schema based on the ERD.
   - Created tables for branches, products, customer accounts, orders, and other necessary entities.

3. **Data Insertion**
   - Inserted extensive data into the tables to simulate real-world scenarios and test the system's functionality.

4. **Triggers**
   - Implemented two key triggers to automate important processes:
     - **Stock Update Trigger:** Automatically updates product stock after an order is placed, ensuring inventory levels are accurate.
     - **Review Log Trigger:** Inserts a log entry after a customer adds a review, helping us track customer interactions and improve our services.

5. **MySQL Queries**
   - Crafted several MySQL queries to showcase the flexibility and functionality of our database:
     - Listing customer details.
     - Identifying top customers.
     - Calculating average sales.
     - Aggregating sales by geographical location.

6. **Views**
   - Created two views to simplify invoice generation:
     - **InvoiceHead View:** Summarizes the head and totals information for invoices.
     - **InvoiceDetails View:** Provides detailed information on items included in each invoice.
   - These views enhance efficiency and ease of access to critical data.

## **Database Tables**
1. **Branches:** Represents different branches of the electronics store.
2. **Categories:** Represents product categories with a hierarchical structure using the parent_id.
3. **Customer_Accounts:** Stores information about customers, including their accounts and personal details.
4. **Locations:** Represents various locations with their city, postal code, and address information. It is used to relate different entities to locations.
5. **Logs:** Contains logs for various activities in the system.
6. **Order_Items:** Represents individual items in an order, linked to both orders and products.
7. **Orders:** Contains information about customer orders, including order date, total amount, and payment method.
8. **Products:** Represents products with details such as name, description, price, and available quantity. Linked to vendors and categories.
9. **Reviews:** Contains customer reviews for products, linked to both customers and products.
10. **Vendors:** Represents vendors who supply products to the store, linked to branches.

## **Project Structure**

The project repository includes the following files and directories:

- `README.md`: This file, providing an overview of the project.
- `Entity Relationship Diagram.png`: An image file of the Entity Relationship Diagram.
- `SQL_Project.sql`: SQL script to re-create the project «.

## **Contacts**
- LinkedIn - [Diogo Pires](https://www.linkedin.com/in/diogo-f-m-pires)
- GitHub: [diogo-pires-github](https://github.com/diogo-pires-github)
