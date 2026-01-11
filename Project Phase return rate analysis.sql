SELECT 
    o.order_id,
    o.category,
    o.supplier,
    o.channel,
    o.city,
    o.state,
    r.return_flag
FROM orders o
LEFT JOIN returns r
ON o.order_id = r.order_id;
SELECT
    COUNT(*) AS total_orders,
    SUM(return_flag) AS total_returns,
    ROUND(SUM(return_flag) * 100.0 / COUNT(*), 2) AS return_rate_percent
FROM returns;
SELECT
    o.category,
    COUNT(o.order_id) AS total_orders,
    SUM(r.return_flag) AS returned_orders,
    ROUND(SUM(r.return_flag) * 100.0 / COUNT(o.order_id), 2) AS return_rate_percent
FROM orders o
JOIN returns r
ON o.order_id = r.order_id
GROUP BY o.category
ORDER BY return_rate_percent DESC;
SELECT
    o.supplier,
    COUNT(o.order_id) AS total_orders,
    SUM(r.return_flag) AS returned_orders,
    ROUND(SUM(r.return_flag) * 100.0 / COUNT(o.order_id), 2) AS return_rate_percent
FROM orders o
JOIN returns r
ON o.order_id = r.order_id
GROUP BY o.supplier
ORDER BY return_rate_percent DESC;
SELECT
    o.state,
    COUNT(o.order_id) AS total_orders,
    SUM(r.return_flag) AS returned_orders,
    ROUND(SUM(r.return_flag) * 100.0 / COUNT(o.order_id), 2) AS return_rate_percent
FROM orders o
JOIN returns r
ON o.order_id = r.order_id
GROUP BY o.state
ORDER BY return_rate_percent DESC;
SELECT
    o.channel,
    COUNT(o.order_id) AS total_orders,
    SUM(r.return_flag) AS returned_orders,
    ROUND(SUM(r.return_flag) * 100.0 / COUNT(o.order_id), 2) AS return_rate_percent
FROM orders o
JOIN returns r
ON o.order_id = r.order_id
GROUP BY o.channel
ORDER BY return_rate_percent DESC;

