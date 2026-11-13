CREATE DATABASE production_analysis;

USE production_analysis;

CREATE TABLE production_data (
    record_datetime DATETIME(6),
    machine_id VARCHAR(10),
    alarm_code VARCHAR(20),
    operating_status VARCHAR(30),
    event_start DATETIME(6),
    event_end DATETIME(6),
    duration_ms BIGINT,
    duration_minutes DECIMAL(12,4),
    input_packages BIGINT,
    output_packages BIGINT,
    production_speed INT
);


SELECT COUNT(*) AS total_records
FROM production_data;

-- 1: Total records and machines
SELECT COUNT(*) AS total_records, COUNT(DISTINCT machine_id) AS total_machines
FROM production_data;

-- 2: Machine-wise record count

SELECT machine_id, COUNT(*) AS total_records
FROM production_data
GROUP BY machine_id
ORDER BY total_records DESC;

-- 3. how many records belong to each operating status.
SELECT operating_status, COUNT(*) AS total_records
FROM production_data
GROUP BY operating_status
ORDER BY total_records DESC;

select * from production_data limit 10;

-- 4. identify which machine has recorded the highest downtime.
SELECT
    machine_id,
    ROUND(SUM(duration_minutes) / 60, 2) AS total_downtime_hours
FROM production_data
WHERE operating_status = 'downtime'
GROUP BY machine_id
ORDER BY total_downtime_hours DESC;

-- 5. identify which machine has the highest recorded performance-loss duration.
SELECT
    machine_id,
    ROUND(SUM(duration_minutes) / 60, 2) AS performance_loss_hours
FROM production_data
WHERE operating_status = 'performance_loss'
GROUP BY machine_id
ORDER BY performance_loss_hours DESC;

-- identify how many hours each machine spent actively producing.
SELECT
    machine_id,
    ROUND(SUM(duration_minutes) / 60, 2) AS production_hours
FROM production_data
WHERE operating_status = 'production'
GROUP BY machine_id
ORDER BY production_hours DESC;


-- 7. identify which machine spends the most time in an idle state.
select 
machine_id, ROUND(SUM(duration_minutes) / 60, 2) AS idle_hours
from production_data
where operating_status = 'idle'
GROUP BY machine_id
ORDER BY operating_status DESC;

-- Which alarm codes are associated with the highest recorded downtime?
SELECT
    alarm_code,
    COUNT(*) AS total_events,
    ROUND(SUM(duration_minutes) / 60, 2) AS downtime_hours
FROM production_data
WHERE operating_status = 'downtime'
GROUP BY alarm_code
ORDER BY downtime_hours DESC
LIMIT 5;

-- Business question: Is machine downtime increasing or decreasing over time?
SELECT
    DATE_FORMAT(record_datetime, '%Y-%m') AS month,
    ROUND(SUM(duration_minutes) / 60, 2) AS downtime_hours
FROM production_data
WHERE operating_status = 'downtime'
GROUP BY DATE_FORMAT(record_datetime, '%Y-%m')
ORDER BY month;

-- During which hours of the day is the most downtime recorded?
SELECT
    HOUR(event_start) AS hour_of_day,
    COUNT(*) AS downtime_events,
    ROUND(SUM(duration_minutes) / 60, 2) AS downtime_hours
FROM production_data
WHERE operating_status = 'downtime'
GROUP BY HOUR(event_start)
ORDER BY downtime_hours DESC;

-- Which machine has the highest combined recorded time in downtime and performance loss?
SELECT
    machine_id,
    ROUND(SUM(duration_minutes) / 60, 2) AS combined_loss_hours
FROM production_data
WHERE operating_status IN ('downtime', 'performance_loss')
GROUP BY machine_id
ORDER BY combined_loss_hours DESC;

-- Which machines experience the most downtime in each month?
SELECT
    DATE_FORMAT(record_datetime, '%Y-%m') AS month,
    machine_id,
    ROUND(SUM(duration_minutes) / 60, 2) AS downtime_hours
FROM production_data
WHERE operating_status = 'downtime'
GROUP BY
    DATE_FORMAT(record_datetime, '%Y-%m'),
    machine_id
ORDER BY month, downtime_hours DESC;

-- Which machines record the highest number of alarm-code events?
SELECT
    machine_id,
    alarm_code,
    COUNT(*) AS total_alarm_events
FROM production_data
GROUP BY machine_id, alarm_code
ORDER BY total_alarm_events DESC;

-- When a machine enters downtime, how long does an average downtime event last?
SELECT
    machine_id,
    COUNT(*) AS total_downtime_events,
    ROUND(AVG(duration_minutes), 2) AS avg_downtime_minutes,
    ROUND(MAX(duration_minutes), 2) AS longest_downtime_minutes
FROM production_data
WHERE operating_status = 'downtime'
GROUP BY machine_id
ORDER BY avg_downtime_minutes DESC;


-- Which machine has the highest average production speed when it is actively producing?
SELECT
    machine_id,
    COUNT(*) AS production_records,
    ROUND(AVG(production_speed), 2) AS avg_production_speed,
    MAX(production_speed) AS max_production_speed
FROM production_data
WHERE operating_status = 'production'
GROUP BY machine_id
ORDER BY avg_production_speed DESC;

-- Does a machine's production speed change over time?
SELECT
    DATE_FORMAT(record_datetime, '%Y-%m') AS month,
    machine_id,
    ROUND(AVG(production_speed), 2) AS avg_speed,
    MAX(production_speed) AS max_speed
FROM production_data
WHERE operating_status = 'production'
GROUP BY
    DATE_FORMAT(record_datetime, '%Y-%m'),
    machine_id
ORDER BY month, machine_id;


-- identifies the 20 longest downtime events that are above the average downtime duration across all machines.
SELECT
    machine_id,
    alarm_code,
    event_start,
    event_end,
    ROUND(duration_minutes, 2) AS downtime_minutes
FROM production_data
WHERE operating_status = 'downtime'
AND duration_minutes > (
    SELECT AVG(duration_minutes)
    FROM production_data
    WHERE operating_status = 'downtime'
)
ORDER BY duration_minutes DESC
LIMIT 20;

-- Rank machines by downtime by cte 
WITH machine_downtime AS (
    SELECT
        machine_id,
        SUM(duration_minutes) / 60 AS downtime_hours
    FROM production_data
    WHERE operating_status = 'downtime'
    GROUP BY machine_id
)
SELECT
    machine_id,
    ROUND(downtime_hours, 2) AS downtime_hours,
    DENSE_RANK() OVER (ORDER BY downtime_hours DESC) AS downtime_rank
FROM machine_downtime;

-- Machine-wise operating status percentage
SELECT
    machine_id,
    operating_status,
    ROUND(SUM(duration_minutes) / 60, 2) AS total_hours,
    ROUND(
        SUM(duration_minutes) * 100 /
        SUM(SUM(duration_minutes)) OVER (PARTITION BY machine_id),
        2
    ) AS status_percentage
FROM production_data
GROUP BY machine_id, operating_status
ORDER BY machine_id, status_percentage DESC;














