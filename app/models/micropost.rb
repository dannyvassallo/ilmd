class Micropost < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :drname
  validates :content, length: { maximum: 140, minimum: 5 }
  profanity_filter! :content, :method => 'stars'

  searchable do
    text :drname
    text :content
    integer :id
  end

end
