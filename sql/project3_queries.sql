-- =====================================================
-- DecodeLabs Project 3 - SQL Data Analysis
-- Database: decodelabs_project3
-- Table: orders
-- =====================================================

 
-- =====================================================
-- SELECT DATABASE
-- =====================================================

USE decodelabs_project3;


-- =====================================================
-- CREATE ORDERS TABLE
-- =====================================================

CREATE TABLE IF NOT EXISTS orders (
    OrderID VARCHAR(20),
    Date DATE,
    CustomerID VARCHAR(20),
    Product VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    ShippingAddress VARCHAR(255),
    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50),
    TrackingNumber VARCHAR(50),
    ItemsInCart INT,
    CouponCode VARCHAR(50),
    ReferralSource VARCHAR(50),
    TotalPrice DECIMAL(10,2)
);


-- =====================================================
-- CHECK TABLE STRUCTURE
-- =====================================================

DESCRIBE orders;

-- =====================================================
-- 1. VIEW ALL ORDERS
-- =====================================================

SELECT *FROM orders;

-- =====================================================
-- 2. VIEW FIRST 10 ORDERS
-- =====================================================

SELECT * FROM orders LIMIT 10;


-- =====================================================
-- 3. TOTAL NUMBER OF ORDERS
-- =====================================================

SELECT COUNT(*) AS total_orders FROM orders;


-- =====================================================
-- 4. TOTAL SALES / REVENUE
-- =====================================================

SELECT SUM(TotalPrice) AS total_revenue FROM orders;


-- =====================================================
-- 5. AVERAGE ORDER VALUE
-- =====================================================

SELECT AVG(TotalPrice) AS average_order_value FROM orders;


-- =====================================================
-- 6. HIGHEST ORDER VALUE
-- =====================================================

SELECT MAX(TotalPrice) AS highest_order_value FROM orders;


-- =====================================================
-- 7. LOWEST ORDER VALUE
-- =====================================================

SELECT MIN(TotalPrice) AS lowest_order_value FROM orders;


-- =====================================================
-- 8. ORDERS WITH TOTAL PRICE GREATER THAN 2000
-- =====================================================

SELECT * FROM orders WHERE TotalPrice > 2000;


-- =====================================================
-- 9. ORDERS WITH QUANTITY GREATER THAN 5
-- =====================================================

SELECT * FROM orders WHERE Quantity > 5;


-- =====================================================
-- 10. SHIPPED ORDERS
-- =====================================================

SELECT * FROM orders WHERE OrderStatus = 'Shipped';


-- =====================================================
-- 11. CANCELLED ORDERS
-- =====================================================

SELECT * FROM orders WHERE OrderStatus = 'Cancelled';


-- =====================================================
-- 12. RETURNED ORDERS
-- =====================================================

SELECT * FROM orders WHERE OrderStatus = 'Returned';


-- =====================================================
-- 13. PENDING ORDERS
-- =====================================================

SELECT * FROM orders WHERE OrderStatus = 'Pending';


-- =====================================================
-- 14. ORDERS SORTED BY HIGHEST PRICE
-- =====================================================

SELECT *FROM orders ORDER BY TotalPrice DESC;


-- =====================================================
-- 15. ORDERS SORTED BY LOWEST PRICE
-- =====================================================

SELECT *FROM orders ORDER BY TotalPrice ASC;


-- =====================================================
-- 16. TOTAL ORDERS BY ORDER STATUS
-- =====================================================

SELECT OrderStatus,COUNT(*) AS total_orders FROM orders GROUP BY OrderStatus ORDER BY total_orders DESC;


-- =====================================================
-- 17. TOTAL REVENUE BY ORDER STATUS
-- =====================================================

SELECT OrderStatus, SUM(TotalPrice) AS total_revenue FROM orders GROUP BY OrderStatus ORDER BY total_revenue DESC;


-- =====================================================
-- 18. AVERAGE ORDER VALUE BY PAYMENT METHOD
-- =====================================================

SELECT PaymentMethod, AVG(TotalPrice) AS average_order_value FROM orders
GROUP BY PaymentMethod ORDER BY average_order_value DESC;

-- =====================================================
-- 19. NUMBER OF ORDERS BY PAYMENT METHOD
-- =====================================================

SELECT PaymentMethod, COUNT(*) AS total_orders FROM orders GROUP BY PaymentMethod ORDER BY total_orders DESC;

-- =====================================================
-- 20. REVENUE BY PAYMENT METHOD
-- =====================================================

SELECT PaymentMethod, SUM(TotalPrice) AS total_revenue FROM orders GROUP BY PaymentMethod ORDER BY total_revenue DESC;

-- =====================================================
-- 21. NUMBER OF ORDERS BY PRODUCT
-- =====================================================

SELECT Product, COUNT(*) AS total_orders FROM orders GROUP BY Product ORDER BY total_orders DESC;


-- =====================================================
-- 22. REVENUE BY PRODUCT
-- =====================================================

SELECT Product, SUM(TotalPrice) AS total_revenue FROM orders GROUP BY Product ORDER BY total_revenue DESC;

-- =====================================================
-- 23. QUANTITY SOLD BY PRODUCT
-- =====================================================

SELECT Product, SUM(Quantity) AS total_quantity_sold
FROM orders GROUP BY Product ORDER BY total_quantity_sold DESC;

-- =====================================================
-- 24. AVERAGE PRICE BY PRODUCT
-- =====================================================

SELECT Product, AVG(UnitPrice) AS average_unit_price
FROM orders GROUP BY Product ORDER BY average_unit_price DESC;

-- =====================================================
-- 25. NUMBER OF ORDERS BY REFERRAL SOURCE
-- =====================================================

SELECT ReferralSource,COUNT(*) AS total_orders FROM orders GROUP BY ReferralSource ORDER BY total_orders DESC;

-- =====================================================
-- 26. REVENUE BY REFERRAL SOURCE
-- =====================================================

SELECT
    ReferralSource,
    SUM(TotalPrice) AS total_revenue
FROM orders GROUP BY ReferralSource ORDER BY total_revenue DESC;

-- =====================================================
-- 27. ORDERS WITH COUPON CODES
-- =====================================================

SELECT * FROM orders WHERE CouponCode IS NOT NULL AND CouponCode <> '';

-- =====================================================
-- 28. NUMBER OF ORDERS USING EACH COUPON
-- =====================================================

SELECT CouponCode, COUNT(*) AS total_orders
FROM orders WHERE CouponCode IS NOT NULL AND CouponCode <> '' GROUP BY CouponCode ORDER BY total_orders DESC;

-- =====================================================
-- 29. SALES BY DATE
-- =====================================================

SELECT Date, SUM(TotalPrice) AS daily_revenue FROM orders GROUP BY Date ORDER BY Date;

-- =====================================================
-- 30. NUMBER OF ORDERS BY DATE
-- =====================================================

SELECT Date,COUNT(*) AS total_orders FROM orders GROUP BY Date ORDER BY Date;


-- =====================================================
-- 31. TOP 10 HIGHEST VALUE ORDERS
-- =====================================================

SELECT
    OrderID,
    CustomerID,
    Product,
    Quantity,
    TotalPrice
FROM orders ORDER BY TotalPrice DESC LIMIT 10;

-- =====================================================
-- 32. TOP 10 PRODUCTS BY REVENUE
-- =====================================================

SELECT Product, SUM(TotalPrice) AS total_revenue
FROM orders GROUP BY Product ORDER BY total_revenue DESC LIMIT 10;

-- =====================================================
-- 33. CUSTOMERS WITH MORE THAN ONE ORDER
-- =====================================================

SELECT CustomerID, COUNT(*) AS total_orders FROM orders GROUP BY CustomerID HAVING COUNT(*) > 1 ORDER BY total_orders DESC;

-- =====================================================
-- 34. CUSTOMERS WITH HIGHEST TOTAL SPENDING
-- =====================================================

SELECT CustomerID, SUM(TotalPrice) AS total_spending FROM orders GROUP BY CustomerID ORDER BY total_spending DESC LIMIT 10;

-- =====================================================
-- 35. ORDER STATUS SUMMARY
-- =====================================================

SELECT OrderStatus,
    COUNT(*) AS order_count,
    SUM(TotalPrice) AS revenue,
    AVG(TotalPrice) AS average_order_value
FROM orders GROUP BY OrderStatus ORDER BY revenue DESC;

-- =====================================================
-- 36. PAYMENT METHOD SUMMARY
-- =====================================================

SELECT
    PaymentMethod,
    COUNT(*) AS order_count,
    SUM(TotalPrice) AS revenue,
    AVG(TotalPrice) AS average_order_value
FROM orders GROUP BY PaymentMethod ORDER BY revenue DESC;


-- =====================================================
-- 37. PRODUCT PERFORMANCE SUMMARY
-- =====================================================

SELECT
    Product,
    COUNT(*) AS number_of_orders,
    SUM(Quantity) AS quantity_sold,
    SUM(TotalPrice) AS revenue,
    AVG(UnitPrice) AS average_unit_price
FROM orders
GROUP BY Product
ORDER BY revenue DESC;

-- =====================================================
-- 38. REFERRAL SOURCE PERFORMANCE
-- =====================================================

SELECT
    ReferralSource,
    COUNT(*) AS number_of_orders,
    SUM(TotalPrice) AS revenue,
    AVG(TotalPrice) AS average_order_value
FROM orders GROUP BY ReferralSource ORDER BY revenue DESC;

