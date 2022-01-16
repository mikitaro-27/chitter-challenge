require 'pg'

class User

  def self.register(name:, username:, email:, password:)
    output = database_connect.exec_params("INSERT INTO peepers (name, username, email, password) VALUES ($1, $2, $3, $4) RETURNING id, name, username, email, password;", [name, username, email, password])
    User.new(id: output[0]['id'], name: output[0]['name'], username: output[0]['username'], email: output[0]['email'], password: output[0]['password'])
  end

  def self.find_by_id(id)
    output = database_connect.query("SELECT * FROM peepers WHERE id = #{id};")
    User.new(id: output[0]['id'], name: output[0]['name'], username: output[0]['username'], email: output[0]['email'], password: output[0]['password'])
  end

  def self.sign_in(username, password)
    output = database_connect.query("SELECT * FROM peepers WHERE username='#{username}' AND password='#{password}';")
    begin
      output[0]
    rescue IndexError
      false
    else
      User.new(id: output[0]['id'], name: output[0]['name'], username: output[0]['username'], email: output[0]['email'], password: output[0]['password'])
    end
  end

  def self.database_connect
    ENV['ENVIRONMENT'] == 'test' ? PG.connect(dbname: 'chitter_test') : PG.connect(dbname: 'chitter')
  end

  attr_reader :id, :username

  def initialize(id:, name:, username:, email:, password:)
    @id = id
    @name = name
    @username = username
    @email = email
    @password = password
  end

end