SELECT `User_ID`, `Product_ID`, `Category`, `Final_Price(Rs.)`, `Payment_Method`, `Purchase_Date`
FROM ecommerce_dataset_updated
LIMIT 10;
SELECT `User_ID`, `Product_ID`, `Category`, `Final_Price(Rs.)`, `Payment_Method`, `Purchase_Date`
FROM ecommerce_dataset_updated
WHERE `Final_Price(Rs.)` > 200;
SELECT `User_ID`, `Product_ID`, `Category`, `Final_Price(Rs.)`
FROM ecommerce_dataset_updated
ORDER BY `Final_Price(Rs.)` DESC
LIMIT 10;
SELECT `Category`, SUM(`Final_Price(Rs.)`) AS total_revenue
FROM ecommerce_dataset_updated
GROUP BY `Category`
ORDER BY total_revenue DESC;
SELECT `Payment_Method`, COUNT(*) AS purchases, AVG(`Final_Price(Rs.)`) AS avg_spend
FROM ecommerce_dataset_updated
GROUP BY `Payment_Method`
ORDER BY purchases DESC;
CREATE TABLE products AS
SELECT DISTINCT `Product_ID`, `Category`, `Price (Rs.)`
FROM ecommerce_dataset_updated;
CREATE TABLE customers AS
SELECT DISTINCT `User_ID`
FROM ecommerce_dataset_updated;
SELECT e.`User_ID`, e.`Product_ID`, p.`Category`, e.`Final_Price(Rs.)`
FROM ecommerce_dataset_updated e
INNER JOIN products p ON e.`Product_ID` = p.`Product_ID`
LIMIT 20;
SELECT c.`User_ID`, e.`Product_ID`, e.`Final_Price(Rs.)`
FROM customers c
LEFT JOIN ecommerce_dataset_updated e ON c.`User_ID` = e.`User_ID`
LIMIT 20;
SELECT c.`User_ID`, e.`Product_ID`, e.`Final_Price(Rs.)`
FROM customers c
RIGHT JOIN ecommerce_dataset_updated e ON c.`User_ID` = e.`User_ID`
LIMIT 20;
SELECT `User_ID`, SUM(`Final_Price(Rs.)`) AS total_spent
FROM ecommerce_dataset_updated
GROUP BY `User_ID`
ORDER BY total_spent DESC
LIMIT 10;
SELECT `User_ID`
FROM ecommerce_dataset_updated
GROUP BY `User_ID`
HAVING SUM(`Final_Price(Rs.)`) > (
    SELECT AVG(user_total) FROM (
        SELECT SUM(`Final_Price(Rs.)`) AS user_total
        FROM ecommerce_dataset_updated
        GROUP BY `User_ID`
    ) t
);
SELECT `User_ID`
FROM ecommerce_dataset_updated
GROUP BY `User_ID`
HAVING SUM(`Final_Price(Rs.)`) = (
    SELECT MAX(total_spent) FROM (
        SELECT `User_ID`, SUM(`Final_Price(Rs.)`) AS total_spent
        FROM ecommerce_dataset_updated
        GROUP BY `User_ID`
    ) x
);
SELECT SUM(`Final_Price(Rs.)`) AS total_revenue, AVG(`Final_Price(Rs.)`) AS avg_order_value
FROM ecommerce_dataset_updated;
CREATE VIEW monthly_sales AS
SELECT DATE_FORMAT(STR_TO_DATE(`Purchase_Date`, '%d-%m-%Y'), '%Y-%m') AS month,
       SUM(`Final_Price(Rs.)`) AS sales,
       COUNT(*) AS orders
FROM ecommerce_dataset_updated
GROUP BY month;
CREATE VIEW category_revenue AS
SELECT `Category`, SUM(`Final_Price(Rs.)`) AS revenue, COUNT(*) AS orders
FROM ecommerce_dataset_updated
GROUP BY `Category`;
SELECT * FROM monthly_sales ORDER BY month DESC LIMIT 12;
SELECT * FROM category_revenue ORDER BY revenue DESC;
CREATE INDEX idx_user_id ON ecommerce_dataset_updated(`User_ID`);
CREATE INDEX idx_product_id ON ecommerce_dataset_updated(`Product_ID`);
CREATE INDEX idx_category ON ecommerce_dataset_updated(`Category`);
CREATE INDEX idx_purchase_date ON ecommerce_dataset_updated(`Purchase_Date`);



