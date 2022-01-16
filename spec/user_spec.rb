require 'user'
require './spec/database_helpers'

describe User do
  describe '.register' do
    it 'creates a user and makes a database entry' do
      user = User.register(name: 'John', username: 'johnny100', email: 'johnsmith@myemail.com', password: '12345')
      persisted_data = persisted_data(user.id, 'peepers')

      p persisted_data
      expect(user).to be_a User
      expect(user.id).to eq persisted_data[0]['id']
      expect(persisted_data[0]['name']).to eq 'John'
      expect(user.username).to eq 'johnny100'
      expect(persisted_data[0]['email']).to eq 'johnsmith@myemail.com'
      expect(persisted_data[0]['password']).to eq '12345'
    end
  end

  describe '.find_by_id' do
    it 'returns user object by id' do
      user = User.register(name: 'John', username: 'johnny100', email: 'johnsmith@myemail.com', password: '12345')
      
      retrieved_user = User.find_by_id(user.id)
      expect(retrieved_user.id).to eq user.id
      expect(retrieved_user.username).to eq user.username
    end
  end

  describe '.sign_in' do
    it 'signs in given correct details' do
      user = User.register(name: 'John', username: 'johnny100', email: 'johnsmith@myemail.com', password: '12345')
      persisted_data = persisted_data(user.id, 'peepers')

      signed_in_user = User.sign_in('johnny100', '12345')

      expect(signed_in_user).to be_a User
      expect(signed_in_user.id).to eq user.id
      expect(signed_in_user.username).to eq user.username
    end


  end
end