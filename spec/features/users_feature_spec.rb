require 'rails_helper'

describe 'user management' do 
	context 'users are not signed in' do 
		it 'users can sign up' do
			visit '/idontgeddits'
			click_link 'Sign Up'
			fill_in 'Username', with: "cluless"
			fill_in 'Email', with: "whmail@hotmail.com"
			fill_in 'Password', with: "12345678"
			fill_in 'Password confirmation', with: "12345678"
			click_button 'Sign up'
			expect(page).to have_content 'Welcome! You have signed up successfully'
		end

		it ' users can sign up' do 
			@user = User.create(username: "clueless", email: "whatmail@hotmail.com", password: "12345678", password_confirmation: "12345678")
			visit '/idontgeddits'
			click_link 'Sign In'
			fill_in 'Email', with: "whatmail@hotmail.com"
			fill_in "Password", with: "12345678"
			click_button "Sign in"
			expect(page).to have_content 'Signed in successfully.'
		end
	end

	context 'users are signed in' do 
			
			before(:each) do 
				User.create(username: "clueless", email: "whatmail@hotmail.com", password: "12345678", password_confirmation: "12345678")   
				visit '/idontgeddits'
				click_link 'Sign In'
				fill_in 'Email', with: "whatmail@hotmail.com"
				fill_in "Password", with: "12345678"
				click_button "Sign in"
			end

		it 'lets users sign out' do 
			click_link 'Sign Out'
			expect(page).to have_content 'Signed out successfully'
		end
	end

end