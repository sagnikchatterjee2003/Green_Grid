-- Query 1: Peak hour usage per meter

WITH ranked_usage AS (
  SELECT 
    meter_id,
    HOUR(reading_time) AS hour_of_day,
    SUM(units_consumed) AS total_units,
    ROW_NUMBER() OVER (PARTITION BY meter_id ORDER BY SUM(units_consumed) DESC) AS rn
  FROM 
    consumption_logs
  GROUP BY 
    meter_id, hour_of_day
)
SELECT 
  meter_id,
  hour_of_day,
  total_units
FROM 
  ranked_usage
WHERE 
  rn = 1;


-- Query 2: Zone-wise total energy consumed
SELECT 
    z.zone_id,
    z.zone_name,
    SUM(cl.units_consumed) AS total_units_consumed
FROM 
    consumption_logs cl
JOIN 
    meters m ON cl.meter_id = m.meter_id
JOIN 
    customers c ON m.customer_id = c.customer_id
JOIN 
    zones z ON c.zone_id = z.zone_id
GROUP BY 
    z.zone_id, z.zone_name
ORDER BY 
    z.zone_id ;


-- Query 3: Billing summaries per customer
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(b.bill_id) AS total_bills,
    SUM(b.amount) AS total_billed_amount,
    SUM(CASE WHEN b.payment_status = 'unpaid' THEN 1 ELSE 0 END) AS unpaid_bills
FROM 
    billing b
JOIN 
    meters m ON b.meter_id = m.meter_id
JOIN 
    customers c ON m.customer_id = c.customer_id
GROUP BY 
    c.customer_id, c.customer_name
ORDER BY 
    customer_id ;
