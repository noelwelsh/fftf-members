require_relative 'mysql'

def import(input, host, user, password, database)#
  my_mysql = ->(cmd) {
    mysql(cmd, host, user, password, database)
  }

  cmd =
  "mysqlimport --fields-terminated-by='\\t' --fields-optionally-enclosed-by='\"' --verbose=true --compress=true --local=true --host=#{host} --user=#{user} --password=#{password} #{database} #{input}"

  # mysqlimport can use a compressed protocol and have a nice summary
  # report. However it doesn't report details on errors like executing
  # a load data command can. So use the below if you want that
  # information
  #
  #"mysql --host=#{host} --user=#{user} --password=#{password} --execute='load data local infile \"users.csv\" into table users fields terminated by \",\" enclosed by \"\\\"\"; show warnings;' #{database}"


  puts "Running #{cmd}"
  puts `#{cmd}`
  puts `#{my_mysql.call("select count(id), movement_id from users group by movement_id")}`
end
