namespace :dev do
  desc "Configure developer environment."
  task start: :environment do

    show_spinner("Deleting database if it exists.") { %x(rails db:drop:_unsafe) }
    show_spinner("Creating database.") { %x(rails db:create) }
    show_spinner("Migrating tables to the database.") { %x(rails db:migrate) }
    %x(rails dev:add_surv)

  end

  desc "Create survivors and their initial locations."
  task add_surv: :environment do
    show_spinner("Creating survivors and their standard locations.") do
      Random.rand(50..100).times do |i|
        @survivor = Survivor.find_or_create_by!(
          description: Faker::Name.name_with_middle,
          age: Random.rand(18..65),
          sex: Faker::Gender.binary_type,   
          latitude: Faker::Address.latitude,
          longitude: Faker::Address.latitude
        )
      end  
    end
  end

  

  private
    def show_spinner(start_msg, end_msg = "Done!")
      spinner = TTY::Spinner.new("[:spinner] Executing task: #{start_msg}", format: :classic)
      spinner.auto_spin
      yield
      spinner.success("(#{end_msg})")
      puts "App by: Luan de Lima Cruz :D"
    end
    
end
