require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should validate the presence of password' do
      user = User.new(password: nil, password_confirmation: nil)
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should validate the presence of password_confirmation' do
      user = User.new(
        email: "test@test.com",
        first_name: "Test",
        last_name: "User",
        password: "password",
        password_confirmation: nil
      )
      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'should validate that password and password_confirmation match' do
      user = User.new(password: "password", password_confirmation: "different_password")
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(email: "user@example.com", password: "password", password_confirmation: "password", first_name: "Test", last_name: "User")
    end
  
    it 'should return the user if authentication is successful' do
      authenticated_user = User.authenticate_with_credentials("user@example.com", "password")
      expect(authenticated_user).to eq(@user)
    end
  
    it 'should return nil if authentication is unsuccessful' do
      authenticated_user = User.authenticate_with_credentials("user@example.com", "wrongpassword")
      expect(authenticated_user).to be_nil
    end
  
    it 'should authenticate even if there are spaces around email' do
      authenticated_user = User.authenticate_with_credentials("  user@example.com  ", "password")
      expect(authenticated_user).to eq(@user)
    end
    
    it 'should authenticate even if email has different cases' do
      authenticated_user = User.authenticate_with_credentials("USER@EXAMPLE.COM", "password")
      expect(authenticated_user).to eq(@user)
    end
  end
end