require 'pg'

def persisted_data(id, tb_name)
  connection = PG.connect(dbname: 'chitter_test')
  result = connection.query("SELECT * FROM #{tb_name} WHERE id = #{id};")
end