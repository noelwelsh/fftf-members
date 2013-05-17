def mysql(cmd, host, user, password, database)
    "mysql --host=#{host} --user=#{user} --password=#{password} --execute='#{cmd}' #{database}"
end
