require_relative "./concerns/csvable"

class Micropost < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :drname
  validates :content, length: { maximum: 140, minimum: 5 }
  profanity_filter! :content, :method => 'stars'

  CSV_COLUMN_NAMES = %w(user__email user__first_name user__last_name drname content created_at)

  include Csvable

  def self.search(query)
    s = "%#{query}%"
    where("drname ILIKE ? OR content ILIKE ?", s, s)
  end

  # def self.as_csv(microposts)
  #   CSV.generate do |csv|
  #     csv << CSV_COLUMN_NAMES
  #     microposts.each do |item|
  #       csv << item.attributes.values_at(*CSV_COLUMN_NAMES)
  #     end
  #   end
  # end

end
