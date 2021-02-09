DROP TABLE IF EXISTS employer;

CREATE TABLE employer
(
    employer_id         serial primary key,
    employer_name		text not null,
    area_id             integer not null,
    created_at			timestamp not null default current_timestamp 
);

DROP TABLE IF EXISTS vacancy;

CREATE TABLE vacancy
(
    vacancy_id          serial primary key,
    employer_id         integer not null references employer (employer_id),
    position_name		text not null,
    compensation_from	integer,
    compensation_to		integer,
    compensation_gross	bool,
    area_id             integer not null,
    created_at			timestamp not null default current_timestamp 
);

DROP TABLE IF EXISTS applicant;

CREATE TABLE applicant
(
    applicant_id	serial primary key,
    applicant_name	text not null,
    area_id         integer not null,
    created_at		timestamp not null default current_timestamp
);

DROP TABLE IF EXISTS summary;

CREATE TABLE summary
(
    summary_id		serial primary key,
    summary_name    text not null,
    applicant_id	integer not null references applicant (applicant_id),
    area_id         integer not null,
    created_at		timestamp not null default current_timestamp
);

DROP TABLE IF EXISTS application;

CREATE TABLE application
(
    vacancy_id 		integer references vacancy (vacancy_id),
    applicant_id	integer references applicant (applicant_id),
    summary_id		integer not null references summary (summary_id),
    created_at		timestamp not null default current_timestamp,
    PRIMARY KEY (vacancy_id, applicant_id)
);

INSERT INTO employer(employer_name, area_id)
VALUES ('hh.ru', 1),
    ('Яндекс', 1),
    ('Рога и Копыта', 2),
    ('Google', 2),
    ('Иванов и Ко', 3),
    ('Пятёрочка', 4),
    ('DSSL', 1),
    ('Цитрус', 4),
    ('ИТЦ Кинтунуум', 4),
    ('Электроника', 3);

INSERT INTO vacancy (employer_id, position_name, compensation_from, compensation_to, compensation_gross, area_id)
VALUES (1, 'Разработчик', 20000, 30000, true, 1),
    (2, 'Тестировщик', 10000, 20000, true, 1),
    (2, 'Аналитик', 15000, 17000, false, 1),
    (3, 'Бухгалтер', 15000, 20000, false, 2),
    (10, 'Web-разработчик', NULL, NULL, NULL, 1),
    (10, 'Ведущий С++ программист', NULL, NULL, NULL, 3),
    (8, 'JavaScript разработчик (ES2019)', 9000, 13000, false, 4),
    (9, 'Программист C/C++', 7000, 10000, false, 4),
    (6, 'Продавец-кассир', NULL, NULL, NULL, 4),
    (6, 'Директор магазина', NULL, NULL, NULL, 4),
    (7, 'Менеджер по развитию клиентов', NULL, NULL, NULL, 1);

INSERT INTO applicant (applicant_name, area_id)
VALUES ('Иванов Иван Иванович', 1),
    ('Петров Пётр Петрович', 1),
    ('Смирнов Илья Алексеевич', 2),
    ('Сидоров Сидор Сидорович', 3),
    ('Владимиров Владимир Владимирович', 4),
    ('Андреев Андрей Андреевич', 2),
    ('Еремеев Антон Павлович', 1),
    ('Козлова Ирина Олеговна', 4),
    ('Лебедева Вера Васильевна', 2),
    ('Зубова Александра Валерьевна', 3);

INSERT INTO summary (summary_name, applicant_id, area_id)
VALUES ('Разработчик JS', 1, 1),
    ('Программист С++', 2, 1),
    ('Программист С++', 2, 3),
    ('Программист C', 3, 2),
    ('Программист C', 3, 4),
    ('Менеджер', 4, 1),
    ('Водитель B, C', 6, 3),
    ('Менеджер', 7, 3),
    ('Продавец', 8, 4),
    ('Кассир', 9, 4),
    ('Директор', 10, 4),
    ('Бухгалтер', 5, 4);

INSERT INTO application (vacancy_id, applicant_id, summary_id)
VALUES (7, 1, 1),
    (1, 1, 1),
    (6, 2, 2),
    (8, 2, 2),
    (3, 8, 5),
    (9, 9, 10),
    (11, 4, 6),
    (10, 10, 11),
    (11, 7, 8),
    (4, 5, 12);
