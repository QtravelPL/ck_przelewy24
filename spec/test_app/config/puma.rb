workers Integer(ENV['PUMA_WORKERS'] || 2)
threads Integer(ENV['MIN_THREADS'] || 4), Integer(ENV['MAX_THREADS'] || 4)

preload_app!

rackup DefaultRackup
port ENV['PORT']
environment ENV['RACK_ENV']

on_worker_boot do
 # Puma worker specific setup
 ActiveSupport.on_load(:active_record) do
 config = ActiveRecord::Base.configurations[Rails.env]
 config['pool'] = ENV['MAX_THREADS'] || 4
 ActiveRecord::Base.establish_connection(config)
 end
end
