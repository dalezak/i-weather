starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)

Dir[Rails.root.join('db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end

Dir[Rails.root.join('db', 'seeds', Rails.env, '*.rb')].sort.each do |seed|
  load seed
end

ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)

puts "Seeds completed in #{(ending - starting).round(2)} seconds."
