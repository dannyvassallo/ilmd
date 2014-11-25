require_relative "./concerns/csvable"

class Micropost < ActiveRecord::Base
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      micropost_hash = row.to_hash
      micropost = Micropost.where(id: micropost_hash["id"])

      if micropost.count == 1
        micropost.first.update_attributes(micropost_hash)
      else
        Micropost.create!(micropost_hash)
      end
    end
  end


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
