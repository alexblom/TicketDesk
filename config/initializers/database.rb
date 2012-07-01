# config/initializers/mongo_mapper.rb

# load YAML and connect
database_yaml = YAML::load(File.read(Rails.root + 'config/mongo.yml'))
if database_yaml[Rails.env]
  mongo_database = database_yaml[Rails.env]
  MongoMapper.connection = Mongo::Connection.new(mongo_database['host'], mongo_database['port'], :pool_size => 5, :timeout => 5)
  MongoMapper.database =  mongo_database['database']
  MongoMapper.database.authenticate(mongo_database['username'], mongo_database['password']) if mongo_database['username']
end

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end