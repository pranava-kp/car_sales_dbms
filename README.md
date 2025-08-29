# Car Sale Management System

This is a simple car sales management system developed as a DBMS mini-project. It allows users to manage car sales data through a web interface.

-----

## Prerequisites

Before you begin, ensure you have the following software installed on your system:

  * **MySQL Server**: The database used to store all the data.
  * **Apache Tomcat**: The web server to run the JSP files.
  * **Java Development Kit (JDK)**: Required to compile and run the Java code.

-----

## 🚀 Installation and Setup

Follow these steps to get the project up and running.

### 1\. Database Setup

First, you need to set up the MySQL database. A sample database script is included to make this process easier.

1.  Open your MySQL shell or client.
2.  Execute the `PopulateDB.sql` script included in the project. This script will create the necessary database, tables, views, and insert sample data.

### 2\. Configure Database Connection

Next, you need to update the database connection details in all `.jsp` files.

  * In each `.jsp` file, find the following placeholders and replace them with your actual MySQL credentials:

      * `jdbc:mysql://localhost:3306/rto` (Update the URL if your database name or host is different).
      * `root` (Replace with your MySQL username).
      * `MYSQLPASSWORD` (Replace with your MySQL password).

    **Note**: You must update the password in every file for the application to work.

### 3\. Build the .war Archive

To deploy the application, you need to package the web content into a `.war` (Web Application Archive) file.

1.  Open a terminal or command prompt and navigate to the root `car_sales` folder.

2.  Run the following command. Make sure to **specify the correct path** to the `jar.exe` utility from your JDK installation.

    ```bash
    & "C:\Program Files\Java\jdk-21\bin\jar.exe" -cvf car_sales.war -C .\web_content .
    ```

    ⚠️ **Important**: The path `"C:\Program Files\Java\jdk-21\bin\jar.exe"` is an example. Your actual path may differ depending on your JDK version and installation directory.

### 4\. Deploy to Apache Tomcat

Finally, deploy the generated `.war` file to your Tomcat server.

1.  Start your Apache Tomcat server.
2.  Open the Tomcat Manager App in your web browser (usually at `http://localhost:8080/manager/html`).
3.  In the "WAR file to deploy" section, upload the `car_sales.war` file you created in the previous step.
4.  Once uploaded, Tomcat will automatically deploy the application. You can then access it at `http://localhost:8080/car_sales`.