# Car Sale Management System (DBMS Mini Project)

**Requirements**
MySQL Server
Apache Tomcat
Java 

**Steps**
1. Create a new Database in mysql and replace the JDBC driver if necessary.
2. The DB URL, username and password must be updated in each file
3. Replace the texts `MYSQLURL`, `MYSQLUSERNAME` and `MYSQLPASSWORD` across all appearing files in this project
   A Sample Database has been included in the project, this handles everything from creating a DB to Insertion of values and views.
   This task can be done by executing the `PopulateDB.sql` file in MySQL Shell. 
4. After the databse is setup and all `.jsp ` files are configured correctly, they must be converted to a `.war` archive to upload into ApacheTomcat
   This action can be done by executing the following in car_sales folder
   ```
   cd car_sales
   & "C:\Program Files\Java\jdk-21\bin\jar.exe" -cvf car_sales.war -C .\web_content .
   ```
   ⚠️ Correct Java bin path must be specefied ⚠️
5. Deploy the frontend by uploading the .war file in ApacheTomcat Manager
