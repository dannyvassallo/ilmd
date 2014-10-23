class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :content, length: { maximum: 140, minimum: 5 }

  searchable do
    text :drname
    text :content
  end

end
