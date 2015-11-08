class Photo < ActiveRecord::Base
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "public/img/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
  belongs_to :user, :foreign_key => 'avatar_id'
end
