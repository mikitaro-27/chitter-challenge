require './lib/user'

feature 'register as user' do
  scenario 'website visitor can register' do
    visit '/'
    click_on 'Register'
    fill_in('user-name', with: 'John')
    fill_in('user-username', with: 'johnny100')
    fill_in('user-email', with: 'john@myemail.com')
    fill_in('user-password', with: '12345')
    click_on 'Register'
    
    expect(current_path).to eq '/'
    
    # not sure how else to test this.
  end
end