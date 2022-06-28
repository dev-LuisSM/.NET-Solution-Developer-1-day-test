-- Industry Table --

CREATE TABLE Industry(
    ID_Industry char NOT NULL,
    Industry_Name varchar(255),
    Market_Value varchar(255),
    PRIMARY KEY (ID_Industry)
);

INSERT INTO Industry (ID_Industry, Industry_Name, Market_Value) 
VALUES 
    ('J', 'Consumer Electronics', '8 Billion'),
    ('B', 'Mobile Telecoms', '2 Billion');

-- Salesperson Table --

CREATE TABLE Salesperson(
    ID_Salesperson int NOT NULL,
    SP_Name varchar(255),
    SP_Age int,
    SP_Salary int,
    PRIMARY KEY (ID_Salesperson)
);

INSERT INTO Salesperson (ID_Salesperson, SP_Name, SP_Age, SP_Salary) 
VALUES 
    (1, 'Abe', 61, 140000),
    (2, 'Bob', 34, 44000),
    (5, 'Chris', 34, 40000),
    (7, 'Dan', 41, 52000),
    (8, 'Ken', 57, 115000),
    (11, 'Joe', 38, 38000);

-- Customer Table --

CREATE TABLE Customer(
    ID_Customer int NOT NULL,
    Customer_Name varchar(255),
    Customer_City varchar(255),
    Industry_Type char,
    PRIMARY KEY (ID_Customer),
    FOREIGN KEY (Industry_Type) REFERENCES Industry(ID_Industry)
);

INSERT INTO Customer (ID_Customer, Customer_Name, Customer_City, Industry_Type) 
VALUES 
    (4, 'Samsonic', 'Pleasant', 'J'),
    (6, 'Panasonic', 'Oacktown', 'J'),
    (7, 'Samung', 'Jackson', 'B'),
    (9, 'Orange', 'Jackson', 'B');

-- Orders Table --

CREATE TABLE Orders(
    Order_Number int NOT NULL,
    Order_Date date,
    Customer_ID int,
    Salesperson_ID int,
    Amount int,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(ID_Customer),
    FOREIGN KEY (Salesperson_ID) REFERENCES Salesperson(ID_Salesperson)
);

INSERT INTO Orders (Order_Number, Order_Date, Customer_ID, Salesperson_ID, Amount) 
VALUES
    (10, '2019/2/8', 4, 2, 5400),
    (20, '2019/1/30', 4, 8, 18000),
    (30, '2019/6/7', 9, 1, 4600),
    (40, '2019/7/1', 7, 2, 24000),
    (50, '2018/3/2', 6, 7, 6000),
    (60, '2019/2/3', 6, 7, 7200),
    (70, '2018/6/5', 9, 7, 1500),
    (80, '2019/5/5', 7, 2, 3400),
    (90, '2020/1/1', 9, 1, 22000);


-- Names of all salespeople that have an order with Samsonic --
SELECT Salesperson.SP_Name as Salespeson, Customer.Customer_Name as Customer
  FROM ((Orders 
  INNER JOIN Salesperson ON Orders.Salesperson_ID = Salesperson.ID_Salesperson)
  INNER JOIN Customer ON Orders.Customer_ID = Customer.ID_Customer)
  WHERE Orders.Customer_ID = 4;

-- Query that shows the following per person, in one result --
-- Number of sales (No_of_sales) --
-- Largest Sale (Largest_sale) --
-- Average number of days between sales ()--
-- Average sale per sales person (Average_sale) --

SELECT Salesperson.SP_Name as Salespeson, 
  COUNT(*) as No_of_sales, 
  MAX(Amount) as Largest_sale,
  ROUND(AVG(Amount),2) as Average_sale
  FROM (Orders 
  INNER JOIN Salesperson ON Orders.Salesperson_ID = Salesperson.ID_Salesperson)
  GROUP BY Salesperson_ID;

-- Alternative way how to evaluate sales person --

-- Salesperson who has the largest sale in 2019
SELECT Salesperson.SP_Name as Salespeson, 
  MAX(Amount) as Largest_sale,
  Order_Date
  FROM (Orders 
  INNER JOIN Salesperson ON Orders.Salesperson_ID = Salesperson.ID_Salesperson)
  WHERE Order_Date BETWEEN '2019-01-01' and '2019-12-31'
  GROUP BY Amount DESC;
