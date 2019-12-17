class ImageDetail < ApplicationRecord
  validates :url, presence: true
  validates :text, presence: true

  def self.as_json_query
    return {
        only: [:id, :text, :url]
    }
  end
end