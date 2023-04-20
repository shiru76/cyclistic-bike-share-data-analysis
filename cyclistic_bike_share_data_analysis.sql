-- Creating a table
CREATE TABLE cyclistic_tripdata (
	ride_id NVARCHAR(255) NOT NULL,
	rideable_type NVARCHAR(255),
	started_at DATETIME,
	ended_at DATETIME,
	start_station_name NVARCHAR(255),
	start_station_id NVARCHAR(255),
	end_station_name NVARCHAR(255),
	end_station_id NVARCHAR(255),
	start_lat FLOAT,
	start_lng FLOAT,
	end_lat FLOAT,
	end_lng FLOAT,
	member_casual NVARCHAR(255)
)

INSERT INTO cyclistic_tripdata
SELECT *
FROM CyclisticDatabase..tripdata_202204
UNION ALL
SELECT *
FROM CyclisticDatabase..tripdata_202205
UNION ALL
SELECT *
FROM CyclisticDatabase..tripdata_202206
UNION ALL
SELECT *
FROM CyclisticDatabase..tripdata_202207
UNION ALL
SELECT *
FROM CyclisticDatabase..tripdata_202208
UNION ALL
SELECT *
FROM CyclisticDatabase..tripdata_202209
UNION ALL
SELECT *
FROM CyclisticDatabase..tripdata_202210
UNION ALL
SELECT *
FROM CyclisticDatabase..tripdata_202211
UNION ALL
SELECT *
FROM CyclisticDatabase..tripdata_202212
UNION ALL
SELECT *
FROM CyclisticDatabase..tripdata_202301
UNION ALL
SELECT *
FROM CyclisticDatabase..tripdata_202303
UNION ALL
SELECT *
FROM CyclisticDatabase..tripdata_202302

-- Clean the data
ALTER TABLE cyclistic_tripdata
DROP COLUMN start_lat

ALTER TABLE cyclistic_tripdata
DROP COLUMN start_lng

ALTER TABLE cyclistic_tripdata
DROP COLUMN end_lat

ALTER TABLE cyclistic_tripdata
DROP COLUMN end_lng

--DELETE FROM cyclistic_tripdata
--WHERE start_station_name IS NULL OR end_station_name IS NULL

-- Number of cyclist with membership
SELECT 
	member_casual, 
	COUNT(*) AS total_num_of_membership
FROM cyclistic_tripdata
GROUP BY member_casual

-- Ride length of cyclist
SELECT 
	member_casual,
	started_at, 
	ended_at, 
	DATEDIFF(MINUTE, started_at, ended_at) AS ride_length
FROM cyclistic_tripdata 
ORDER BY ride_length DESC

-- Average ride length per membership
SELECT 
	member_casual,
	AVG(DATEDIFF(MINUTE, started_at, ended_at)) AS ave_ride_length
FROM cyclistic_tripdata
GROUP BY member_casual
ORDER BY ave_ride_length DESC

-- Number of cyclist per month
SELECT 
	DATENAME(MONTH, ended_at) AS trip_month, 
	COUNT(*) AS num_of_users,
	COUNT(
		CASE 
			WHEN member_casual = 'member' THEN 1
			ELSE NULL
		END
	) AS num_of_member,
	COUNT(
		CASE 
			WHEN member_casual = 'casual' THEN 1
			ELSE NULL
		END
	) AS num_of_casual
FROM cyclistic_tripdata
GROUP BY 
	DATENAME(MONTH, ended_at),
	MONTH(ended_at)
ORDER BY MONTH(ended_at)

-- Average ride length per month per membership
SELECT 
	DATENAME(MONTH, ended_at) AS trip_month, 
	AVG(DATEDIFF(MINUTE, started_at, ended_at)) AS ave_ride_length,
	AVG(
		CASE 
			WHEN member_casual = 'member' THEN DATEDIFF(MINUTE, started_at, ended_at)
			ELSE 0
		END
	) AS ave_ride_length_member,
	AVG(
		CASE 
			WHEN member_casual = 'casual' THEN DATEDIFF(MINUTE, started_at, ended_at)
			ELSE 0
		END
	) AS ave_ride_length_casual
FROM cyclistic_tripdata
GROUP BY 
	DATENAME(MONTH, ended_at),
	MONTH(ended_at)
ORDER BY  MONTH(ended_at)

-- Number of cyclist per day
SELECT 
	DATENAME(WEEKDAY, ended_at) AS trip_day, 
	COUNT(*) AS num_of_users,
	COUNT(
		CASE 
			WHEN member_casual = 'member' THEN 1
			ELSE NULL
		END
	) AS num_of_member,
	COUNT(
		CASE 
			WHEN member_casual = 'casual' THEN 1
			ELSE NULL
		END
	) AS num_of_casual
FROM cyclistic_tripdata
GROUP BY 
	DATENAME(WEEKDAY, ended_at),
	DATEPART(WEEKDAY, ended_at)
ORDER BY DATEPART(WEEKDAY, ended_at)

-- Average ride length per day per membership
SELECT 
	DATENAME(WEEKDAY, ended_at) AS trip_month, 
	AVG(DATEDIFF(MINUTE, started_at, ended_at)) AS ave_ride_length,
	AVG(
		CASE 
			WHEN member_casual = 'member' THEN DATEDIFF(MINUTE, started_at, ended_at)
			ELSE 0
		END
	) AS ave_ride_length_member,
	AVG(
		CASE 
			WHEN member_casual = 'casual' THEN DATEDIFF(MINUTE, started_at, ended_at)
			ELSE 0
		END
	) AS ave_ride_length_casual
FROM cyclistic_tripdata
GROUP BY 
	DATENAME(WEEKDAY, ended_at),
	DATEPART(WEEKDAY, ended_at)
ORDER BY DATEPART(WEEKDAY, ended_at)

-- Number of cyclist per station
SELECT TOP 10
	station_tbl.station_name,
	SUM(station_tbl.num_of_cyclist) AS num_of_cyclist,
	SUM(station_tbl.num_of_member) AS num_of_member,
	SUM(station_tbl.num_of_casual) AS num_of_casual
FROM (
	SELECT 
		start_station_name AS station_name,
		COUNT(*) AS num_of_cyclist,
		COUNT(
			CASE 
				WHEN member_casual = 'member' THEN 1
				ELSE NULL
			END
		) AS num_of_member,
		COUNT(
			CASE 
				WHEN member_casual = 'casual' THEN 1
				ELSE NULL
			END
		) AS num_of_casual
	FROM cyclistic_tripdata
	GROUP BY 
		start_station_name
	UNION
	SELECT 
		end_station_name,
		COUNT(*),
		COUNT(
			CASE 
				WHEN member_casual = 'member' THEN 1
				ELSE NULL
			END
		) AS num_of_member,
		COUNT(
			CASE 
				WHEN member_casual = 'casual' THEN 1
				ELSE NULL
			END
		) AS num_of_casual
	FROM cyclistic_tripdata
	GROUP BY 
		end_station_name
) AS station_tbl
WHERE station_tbl.station_name IS NOT NULL
GROUP BY station_tbl.station_name
ORDER BY num_of_cyclist DESC