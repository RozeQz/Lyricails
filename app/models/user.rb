class User < ApplicationRecord
  attr_accessor :old_password

  has_secure_password validations: false
  has_many :posts, dependent: :destroy
  has_one_attached :avatar

  acts_as_voter

  after_commit :add_default_avatar, on: %i[create update]
  before_save :add_default_avatar

  validates :avatar, content_type: %i[png jpg jpeg], size: { less_than: 5.megabytes }

  validate :password_presence
  validate :correct_old_password, on: :update, if: -> { password.present? }
  validate :password_complexity

  validates :password, confirmation: { message: 'user.errors.password.confirmation' },
                       allow_blank: true,
                       length: { minimum: 6, maximum: 70, message: 'user.errors.password.length' }

  validates :email, presence: { message: 'user.errors.email.presence' },
                    uniqueness: { message: 'user.errors.email.uniqueness' },
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'user.errors.email.format' }
  # validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  validates :username, presence: { message: 'user.errors.username.presence' },
                       uniqueness: { message: 'user.errors.username.uniqueness' }

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_avatar.jpg'
          )
        ),
        filename: 'default_avatar.jpg',
        content_type: 'image/jpg'
      )
    end
  end

  private

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, message: 'user.errors.password.old_password'
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])/

    errors.add :password, message: 'user.errors.password.complexity'
  end

  def password_presence
    errors.add(:password, :blank) unless password_digest.present?
  end
end
