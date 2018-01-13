# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count


port        ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }


app_dir = File.expand_path("../../..", __FILE__)
shared_dir = "#{app_dir}/shared"

# Set up socket location
bind "unix://#{shared_dir}/tmp/sockets/puma.sock"

# Logging
stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{shared_dir}/tmp/pids/puma.pid"
state_path "#{shared_dir}/tmp/pids/puma.state"
activate_control_app


# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

