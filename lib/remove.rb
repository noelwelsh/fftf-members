# Removes imported data from the database

require_relative 'mysql'

def remove(lower_limit, host, user, password, database)
  my_mysql = ->(cmd) {
    mysql(cmd, host, user, password, database)
  }

  count = "select count(id) from users"
  delete = "delete from users where id > #{lower_limit}"

  count_start = `#{my_mysql.call(count)}`
  puts "Starting with #{count_start} users"
  puts `#{my_mysql.call(delete)}`
  count_end = `#{my_mysql.call(count)}`
  puts "Ending with #{count_end} users"
end
