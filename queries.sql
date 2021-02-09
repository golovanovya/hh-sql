SELECT
    position_name,
    v.area_id AS vacancy_area_id,
    employer_name
FROM vacancy AS v
INNER JOIN employer AS e ON v.employer_id = e.employer_id
WHERE
    compensation_from IS NULL
    AND compensation_to IS NULL
ORDER BY v.created_at DESC
LIMIT 10;

SELECT
    AVG(compensation_from) AS avg_compensation_from,
    AVG(compensation_to) AS avg_compensation_to,
    AVG((compensation_to + compensation_from) / 2) AS avg_compensation_avg
FROM (
    SELECT
        CASE
            WHEN compensation_gross IS TRUE
            THEN compensation_to
            ELSE compensation_to * 100 / 87
            END AS compensation_to,
        CASE
            WHEN compensation_gross IS TRUE
            THEN compensation_from
            ELSE compensation_from * 100 / 87
            END AS compensation_from
    FROM vacancy AS v
) AS nv;

WITH count_applications AS (
    SELECT
        employer_id,
        position_name,
        COUNT(applicant_id) application_count
    FROM vacancy AS v
    LEFT JOIN application AS a ON a.vacancy_id = v.vacancy_id
    GROUP BY employer_id, position_name
) SELECT
    employer_name,
    COALESCE(MAX(application_count), 0) AS max_application_count
FROM employer AS e
LEFT JOIN count_applications AS ca ON e.employer_id = ca.employer_id
GROUP BY e.employer_id, employer_name
ORDER BY max_application_count DESC, employer_name
LIMIT 5;

WITH count_applications AS (
    SELECT
        employer_id,
        position_name,
        COUNT(applicant_id) application_count
    FROM vacancy AS v
    LEFT JOIN application AS a ON a.vacancy_id = v.vacancy_id
    GROUP BY employer_id, position_name
) SELECT
    employer_name,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY application_count)
FROM count_applications AS cp
LEFT JOIN employer AS e ON e.employer_id = cp.employer_id
GROUP BY employer_name;

WITH first_applications AS (
    SELECT
        vacancy_id,
        MIN(created_at) AS created_at
    FROM application
    GROUP BY vacancy_id
) SELECT
    area_id,
    MIN(fa.created_at - v.created_at) AS min_application_time,
    MAX(fa.created_at - v.created_at) AS max_applicatin_time
FROM vacancy AS v
LEFT JOIN first_applications AS fa ON v.vacancy_id = fa.vacancy_id
GROUP BY area_id;
