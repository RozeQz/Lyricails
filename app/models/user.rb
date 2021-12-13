class User < ApplicationRecord
  attr_accessor :old_password

  has_secure_password validations: false
  has_many :posts, dependent: :destroy
  # has_many :likes, dependent: :destroy
  has_one_attached :avatar

  acts_as_voter

  after_commit :add_default_avatar, on: %i[create update]
  before_save :add_default_avatar

  validates :avatar, content_type: %i[png jpg jpeg]

  validate :password_presence
  validate :correct_old_password, on: :update, if: -> { password.present? }
  validate :password_complexity

  validates :password, confirmation: { message: 'Пароли не совпадают.' },
                       allow_blank: true,
                       length: { minimum: 6, maximum: 70, message: 'Пароль слишком короткий,
                                                                   минимальная длина - 6 символов.' }

  validates :email, presence: { message: 'Пожалуйста, введите электронную почту.' },
                    uniqueness: { message: 'Пользователь с такой электронной почтой уже зарегистрирован.' },
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Введена некорректная электронная почта.' }
  # validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  validates :username, presence: { message: 'Пожалуйста, введите имя пользователя.' },
                       uniqueness: { message: 'Пользователь с таким именем уже зарегистрирован.' }

  def formatted_created_at
    created_at.strftime('%d.%m.%Y %T %Z')
  end

  def formated_last_login_at
    last_login_at.strftime('%d.%m.%Y %T %Z')
  end

  def avatar_thumbnail(size = 300)
    if avatar.attached?
      avatar.variant(resize: "#{size}x#{size}!").processed
    else
      '../assets/images/default_avatar.jpg'
    end
  end

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

    errors.add :old_password, 'Введен неверный старый пароль.'
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])/

    errors.add :password, message: 'Пароль должнен содержать хотя бы: 1 прописную букву, 1 строчную букву и 1 цифру.'
  end

  def password_presence
    errors.add(:password, :blank) unless password_digest.present?
  end
end
