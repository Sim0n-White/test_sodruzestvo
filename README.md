# README

[![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-6.1.7.8-red)](https://rubyonrails.org/)
[![Ruby](https://img.shields.io/badge/Ruby-3.0.0-red)](https://www.ruby-lang.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-%3E%3D%2012-blue)](https://www.postgresql.org/)

## Описание

Тестовой задание Backend Содружество

## Начало работы

Эти инструкции помогут вам запустить копию проекта на вашем локальном компьютере.

### Предварительные требования

Что необходимо установить для запуска приложения:

- **Ruby** версии 3.0.0 или выше
- **Rails** версии 6.1.7.8 или выше
- **PostgreSQL** версии 12 или выше

### Установка

1. Клонируйте репозиторий:
2. Выполните bundle install
3. Создайте пользователя для БД:

   ```bash
   sudo -u postgres psql
   CREATE USER test_sodruzestvo WITH PASSWORD 'test_sodruzestvo';
   ALTER USER test_sodruzestvo CREATEDB;
4. Создайте БД:

   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
5. Тестирование:

   ```bash
   rspec
   rake rswag:specs:swaggerize
6. Swagger http://localhost:3000/api-docs/index.html
