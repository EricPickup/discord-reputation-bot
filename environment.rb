require 'active_record'
# envrionment.rb
# recursively require all files in ./lib and down that end in .rb
Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder +"/*.rb").each do |file|
    require file
  end
end

# tells activerecord what db file to use
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: '../uwindsor-css-hub/db/production.sqlite3'
)
