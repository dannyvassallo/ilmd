class Micropost < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :drname
  validates :content, length: { maximum: 140, minimum: 5 }
  profanity_filter! :content, :method => 'stars'

  def self.search(query)
    s = "%#{query}%"
    where("drname ILIKE ? OR content ILIKE ?", s, s)
  end

end
