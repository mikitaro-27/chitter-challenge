feature 'existing user can sign in' do
  scenario 'users signs in' do
    visit '/'
    click_on 'Register'
    fill_in('user-name', with: 'John')
    fill_in('user-username', with: 'johnny100')
    fill_in('user-email', with: 'john@myemail.com')
    fill_in('user-password', with: '12345')
    click_on 'Register'

    fill_in 'username', with: 'johnny100'
    fill_in 'password', with: '12345'
    click_on 'Sign in'

    expect(page).to have_content 'You signed in as johnny100'
    expect(page).not_to have_button 'Register'
    expect(page).not_to have_button 'Sign in'
    expect(page).not_to have_field 'username'
    expect(page).not_to have_field 'password'
  end
end