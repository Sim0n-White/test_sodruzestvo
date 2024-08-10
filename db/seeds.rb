# db/seeds.rb

# Удаляем связи между курсами и компетенциями
CourseCompetency.destroy_all

# Удаляем курсы
Course.destroy_all

# Удаляем авторов
Author.destroy_all

# Удаляем компетенции
Competency.destroy_all

# Создаем авторов
authors = Author.create([
  { name: 'Alice Johnson' },
  { name: 'Bob Smith' },
  { name: 'Carol White' }
])

# Создаем компетенции
competencies = Competency.create([
  { name: 'Ruby on Rails', description: 'Framework for building web applications in Ruby.' },
  { name: 'JavaScript', description: 'Programming language for web development.' },
  { name: 'React', description: 'JavaScript library for building user interfaces.' },
  { name: 'SQL', description: 'Language for managing and querying relational databases.' },
  { name: 'Project Management', description: 'Methods and practices for managing projects.' }
])

# Создаем курсы
courses = Course.create([
  { title: 'Intro to Ruby on Rails', description: 'Learn the basics of Rails.', author: authors[0] },
  { title: 'Advanced JavaScript', description: 'Deep dive into JavaScript.', author: authors[1] },
  { title: 'React for Beginners', description: 'Introduction to React.', author: authors[2] },
  { title: 'Mastering SQL', description: 'Become a SQL expert.', author: authors[0] },
  { title: 'Project Management Essentials', description: 'Learn the fundamentals of project management.', author: authors[1] }
])

# Создаем связи между курсами и компетенциями
CourseCompetency.create([
  { course: courses[0], competency: competencies[0] }, # Intro to Ruby on Rails - Ruby on Rails
  { course: courses[1], competency: competencies[1] }, # Advanced JavaScript - JavaScript
  { course: courses[2], competency: competencies[2] }, # React for Beginners - React
  { course: courses[3], competency: competencies[3] }, # Mastering SQL - SQL
  { course: courses[4], competency: competencies[4] },  # Project Management Essentials - Project Management
  { course: courses[1], competency: competencies[0] },
  { course: courses[2], competency: competencies[0] },
  { course: courses[3], competency: competencies[0] },
  { course: courses[4], competency: competencies[0] },
  { course: courses[1], competency: competencies[0] },
  { course: courses[2], competency: competencies[0] },
  { course: courses[3], competency: competencies[0] },
  { course: courses[4], competency: competencies[0] },

])

puts "Seed data created successfully."
