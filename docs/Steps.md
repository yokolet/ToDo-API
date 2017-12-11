# Getting Started

### How this app makes its shape

1. Create and app

    `$ rails new todo-api --api -T --database=postgresql`

2. create .ruby-version file

    ```bash
    $ cd my-api-app
    $ echo 2.4.1 > .ruby-version
    ```

3. add rspec-rails, factory girl, faker, shoulda and databse_cleaner gems

    ```ruby
    group :development, :test do
      # Call 'byebug' anywhere in the code to stop execution and get a debugger console
      gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
      gem 'rspec-rails', '~> 3.6', '>= 3.6.1'
      gem 'factory_girl_rails', '~> 4.8'
      gem 'faker', '~> 1.8', '>= 1.8.4'
      gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2'
      gem 'database_cleaner', '~> 1.6', '>= 1.6.1'
    end
    ```

4. bundle install

5. setup database

    `$ bin/rails db:setup`

6. initialize rspec

    ```bash
    $ bin/rails g rspec:install
    Running via Spring preloader in process 93308
          create  .rspec
          create  spec
          create  spec/spec_helper.rb
          create  spec/rails_helper.rb
    ```

7. create todo by scaffold

    ```bash
    $ bin/rails g scaffold todo title:string order:integer completed:boolean
    Running via Spring preloader in process 46737
          invoke  active_record
          create    db/migrate/20171210052504_create_todos.rb
          create    app/models/todo.rb
          invoke    rspec
          create      spec/models/todo_spec.rb
          invoke      factory_girl
          create        spec/factories/todos.rb
          invoke  resource_route
           route    resources :todos
          invoke  scaffold_controller
          create    app/controllers/todos_controller.rb
          invoke    rspec
          create      spec/controllers/todos_controller_spec.rb
          create      spec/routing/todos_routing_spec.rb
          invoke      rspec
          create        spec/requests/todos_spec.rb
    ```

8. migrate newly created todo model

    ```bash
    $ bin/rails db:migrate
    == 20171210052504 CreateTodos: migrating ======================================
    -- create_table(:todos)
       -> 0.0674s
    == 20171210052504 CreateTodos: migrated (0.0675s) =============================
    ```
 
9. edit `spec/rails_helper.rb` to configure gems
 
    {% gist 506e4d7307939f8e08f06337e539bec0 %}
 

10. Adds model validations

    modify `spec/models/todo_spec.rb`
    
    ```ruby
    require 'rails_helper'
    
    RSpec.describe Todo, type: :model do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:order) }
      it { should validate_presence_of(:completed) }
    end
    ```

12. Run models specs and see tests fail

    ```bash
    $ bin/rake spec:models
    Running via Spring preloader in process 60765
    /Users/yoko/.rbenv/versions/2.4.1/bin/ruby -I/Users/yoko/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/rspec-core-3.7.0/lib:/Users/yoko/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/rspec-support-3.7.0/lib /Users/yoko/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/rspec-core-3.7.0/exe/rspec --pattern ./spec/models/\*\*/\*_spec.rb
    DEPRECATION WARNING: The factory_girl gem is deprecated. Please upgrade to factory_bot. See https://github.com/thoughtbot/factory_bot/blob/v4.9.0/UPGRADE_FROM_FACTORY_GIRL.md for further instructions. (called from <top (required)> at /Users/yoko/Works/learning/portfolio/todo-api/config/application.rb:17)
    FFF
    
    Failures:
    
      1) Todo should validate that :title cannot be empty/falsy
         Failure/Error: it { should validate_presence_of(:title) }
    
           Todo did not properly validate that :title cannot be empty/falsy.
             After setting :title to ‹nil›, the matcher expected the Todo to be
             invalid, but it was valid instead.
         # ./spec/models/todo_spec.rb:4:in `block (2 levels) in <top (required)>'
         # ./spec/rails_helper.rb:79:in `block (3 levels) in <top (required)>'
         # ./spec/rails_helper.rb:78:in `block (2 levels) in <top (required)>'
    
      2) Todo should validate that :order cannot be empty/falsy
         Failure/Error: it { should validate_presence_of(:order) }
    
           Todo did not properly validate that :order cannot be empty/falsy.
             After setting :order to ‹nil›, the matcher expected the Todo to be
             invalid, but it was valid instead.
         # ./spec/models/todo_spec.rb:5:in `block (2 levels) in <top (required)>'
         # ./spec/rails_helper.rb:79:in `block (3 levels) in <top (required)>'
         # ./spec/rails_helper.rb:78:in `block (2 levels) in <top (required)>'
    
      3) Todo should validate that :completed cannot be empty/falsy
         Failure/Error: it { should validate_presence_of(:completed) }
    
           Todo did not properly validate that :completed cannot be empty/falsy.
             After setting :completed to ‹nil›, the matcher expected the Todo to be
             invalid, but it was valid instead.
         # ./spec/models/todo_spec.rb:6:in `block (2 levels) in <top (required)>'
         # ./spec/rails_helper.rb:79:in `block (3 levels) in <top (required)>'
         # ./spec/rails_helper.rb:78:in `block (2 levels) in <top (required)>'
    
    Finished in 0.75981 seconds (files took 2.59 seconds to load)
    3 examples, 3 failures
    
    Failed examples:
    
    rspec ./spec/models/todo_spec.rb:4 # Todo should validate that :title cannot be empty/falsy
    rspec ./spec/models/todo_spec.rb:5 # Todo should validate that :order cannot be empty/falsy
    rspec ./spec/models/todo_spec.rb:6 # Todo should validate that :completed cannot be empty/falsy
    
    /Users/yoko/.rbenv/versions/2.4.1/bin/ruby -I/Users/yoko/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/rspec-core-3.7.0/lib:/Users/yoko/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/rspec-support-3.7.0/lib /Users/yoko/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/rspec-core-3.7.0/exe/rspec --pattern ./spec/models/\*\*/\*_spec.rb failed
    ```

13. modify `app/models/todo.rb`

    ```ruby
    class Todo < ApplicationRecord
      # validation
      validates_presence_of :title, :order, :completed
    end
    ```

14. run model specs again and see all pass

    ```bash
    $ bin/rake spec:models
    Running via Spring preloader in process 60920
    /Users/yoko/.rbenv/versions/2.4.1/bin/ruby -I/Users/yoko/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/rspec-core-3.7.0/lib:/Users/yoko/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/rspec-support-3.7.0/lib /Users/yoko/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/rspec-core-3.7.0/exe/rspec --pattern ./spec/models/\*\*/\*_spec.rb
    DEPRECATION WARNING: The factory_girl gem is deprecated. Please upgrade to factory_bot. See https://github.com/thoughtbot/factory_bot/blob/v4.9.0/UPGRADE_FROM_FACTORY_GIRL.md for further instructions. (called from <top (required)> at /Users/yoko/Works/learning/portfolio/todo-api/config/application.rb:17)
    ...
    
    Finished in 0.75118 seconds (files took 2.64 seconds to load)
    3 examples, 0 failures
    ```


### reference: when something went wrong

- [Undo scaffolding in Rails](https://stackoverflow.com/questions/963420/undo-scaffolding-in-rails)

    ```bash
    $ bin/rails db:rollback
    == 20171211124100 CreateTodos: reverting ======================================
    -- drop_table(:todos)
       -> 0.0321s
    == 20171211124100 CreateTodos: reverted (0.0351s) =============================
    
    $ bin/rails destroy scaffold todo
    Running via Spring preloader in process 59780
          invoke  active_record
          remove    db/migrate/20171211124100_create_todos.rb
          remove    app/models/todo.rb
          invoke    rspec
          remove      spec/models/todo_spec.rb
          invoke      factory_girl
          remove        spec/factories/todos.rb
          invoke  resource_route
           route    resources :todos
          invoke  scaffold_controller
          remove    app/controllers/todos_controller.rb
          invoke    rspec
          remove      spec/controllers/todos_controller_spec.rb
          remove      spec/routing/todos_routing_spec.rb
          invoke      rspec
          remove        spec/requests/todos_spec.rb
    
    ```