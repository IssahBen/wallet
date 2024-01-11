require 'pg'
conn=PG.connect(dbname:'learning',user:'postgres',password:'postgres',host:'localhost')

results=conn.exec('SELECT * FROM account_job')

results.each do |row|
    puts.row.values.join(',')
end
p a
