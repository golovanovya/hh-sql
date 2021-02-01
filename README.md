# Домашнее задание по SQL

Задания оформить в виде SQL-скриптов. Все скрипты должны выполняться без ошибок при последовательном выполнении на чистой базе PostgreSQL.

 - Разработать схему данных для резюме, вакансий, откликов и работодателей.  Зарплаты в вакансии должны быть указаны в виде диапазона (compensation_from, compensation_to) с указанием compensation_gross (true, если зарплата указана до вычета налогов, false, если после вычета налогов), зарплата может быть указана не полностью или не указана вовсе. Схема должна быть в третьей нормальной форме. В остальном вы ограничены только вашей фантазией, но делать слишком большие таблицы или много таблиц тоже не стоит.
 - Заполнить таблицы данными (по 10-20 строк в каждой таблице, но можно и больше, если очень хочется).
 - Вывести название вакансии, город, в котором опубликована вакансия (можно просто area_id), имя работодателя для первых 10 вакансий у которых не указана зарплата, сортировать по дате создания вакансии от новых к более старым.
 - Вывести среднюю максимальную зарплату в вакансиях, среднюю минимальную и среднюю среднюю (compensation_to + compensation_from) / 2 в одном запросе. Значения должны быть указаны до вычета налогов.
 - Вывести топ-5 компаний, получивших максимальное количество откликов на одну вакансию, в порядке убывания откликов. Если более 5 компаний получили одинаковое максимальное количество откликов, отсортировать по алфавиту и вывести только 5.
 - Вывести медианное количество вакансий на компанию. Использовать percentile_cont.
 - Вывести минимальное и максимальное время от создания вакансии до первого отклика для каждого города.
