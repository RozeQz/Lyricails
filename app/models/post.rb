class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  # has_attached_file :photo, styles: {large: "450=450>", thumb: "50x50#"}
  # validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  has_one_attached :music
  validates :music, attached: true, content_type: %i[mp3 wav]

end
