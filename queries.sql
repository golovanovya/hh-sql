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
    INNER JOIN application AS a ON a.vacancy_id = v.vacancy_id
    GROUP BY employer_id, position_name
) SELECT
    employer_name,
    MAX(application_count) AS max_application_count
FROM employer AS e
INNER JOIN count_applications AS ca ON e.employer_id = ca.employer_id
GROUP BY employer_name
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

SELECT
    area_id,
    MIN(a.created_at - v.created_at) AS fastest_application,
    MAX(a.created_at - v.created_at) AS slowest_application
FROM application AS a
INNER JOIN vacancy AS v ON v.vacancy_id = a.vacancy_id
GROUP BY area_id;
