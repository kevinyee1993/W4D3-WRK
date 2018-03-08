class User < ApplicationRecord

  validates :user_name, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: { message: 'Password can\'t be blank'}

  # after_initialize :ensure_session_token
  before_validation :ensure_session_token
  # attr_accessor :session_token

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Cat

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(user_name: username)

    return user if user && user.is_password?(password)
    nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end


  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

end
