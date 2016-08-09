class User < ActiveRecord::Base
  validates :password_digest, :username, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :goals
  has_many :comments

  attr_reader :password

  def self.find_by_credentials(user_name, pw)
    user = User.find_by(username: user_name)
    # return nil if user.nil?
    # return user if user.is_password?(pw)
    return user if user && user.is_password?(pw)

    nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    pw_digest = BCrypt::Password.new(self.password_digest)
    pw_digest.is_password?(pw)
  end
end
