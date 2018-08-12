# frozen_string_literal: true

# Handles user Authentication. Takes a users' email and password and, after
# successful authentication, returns a JSON Web Token with user_id and an
# expiration timer. On error, it will append them and return nil.
class AuthenticateUserCommand < BaseCommand
  private

  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def password_valid?
    user&.authenticate(password)
  end

  def payload
    if password_valid?
      @result = JwtService.encode(contents)
    else
      errors.add(:base, 'Invalid credentials')
    end
  end

  def contents
    {
      user_id: user.id,
      exp: 24.hours.from_now.to_i
    }
  end
end
