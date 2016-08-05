namespace :data_structures do
  namespace :trees do
    task :level_order_traversal, [] => :environment do |t, args|
      `g++ -o tmp/level_order_traversal #{File.dirname(__FILE__)}/level_order_traversal.cpp`
      exec './tmp/level_order_traversal'
    end
  end
end