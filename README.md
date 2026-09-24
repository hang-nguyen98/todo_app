# TodoApp

A Rails web application for organizing personal tasks. Users can create an account, log in, manage categories, and create and track their own todos.

## Features

- User registration, login, logout, and account deletion
- Secure password authentication with bcrypt
- Create, view, edit, update and delete todos
- Set todo priority and completion status
- Organize todos by category
- View all todos or completed todos
- User-specific data access: users can only manage their own todos and categories
- Responsive interface using Bootstrap and Bootstrap Icons

## Tech Stack

- Ruby on Rails 7.2.3
- Ruby 3.x recommended
- SQLite3
- Bootstrap 5.3
- Hotwire (Turbo and Stimulus)
- Import maps for JavaScript

## Requirements

Install the following before setting up the application:

- Ruby 3.x
- Bundler
- SQLite3

## Getting Started

From the `todo_app` directory:

```bash
bundle install
bin/rails server
```

Open [http://localhost:3000](http://localhost:3000) in a browser. You need to create an account through the sign-up page and log in before adding todos or categories.

## Common Commands

```bash
# Start the Rails server
bin/rails server

# Create or update the database
bin/rails db:prepare

# Run database migrations
bin/rails db:migrate

# Open a Rails console
bin/rails console

# Display all routes
bin/rails routes
```

## Project Structure

```text
app/controllers/   Request handling and authentication flows
app/models/        User, Todo, and Category data models
app/views/         HTML views for the app's pages
app/helpers/       Helper methods to support views
app/javascript/    JavaScript libraries 
app/assets/        Images, asset configuration, and custom stylesheets
config/routes.rb   URL and controller mappings
db/migrate/        Database schema migrations
```

## Checking Database Data

The development database is stored in `storage/development.sqlite3`. The
easiest way to inspect records is through the Rails console:

```bash
bin/rails console
```

Then run commands such as:

```ruby
User.count
User.all
Todo.count
Todo.includes(:user, :category).all
Category.all
```

To inspect the SQLite database directly, run this from the `todo_app`
directory:

```bash
sqlite3 storage/development.sqlite3
```

Useful SQLite commands include:

```sql
.tables
.schema todos
SELECT * FROM users;
SELECT * FROM todos;
.quit
```

## Configuration

Development uses SQLite and stores the database at
`storage/development.sqlite3`. Rails credentials and environment-specific
settings live under `config/`. Do not commit passwords, API keys, or other
secrets to the repository.

## Deployment

The project is deployed on Github.
