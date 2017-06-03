class Tag < ApplicationRecord
  # attr_accessible :name
  has_many :taggings
  has_many :posts, through: :taggings

  def self.counts
    self.select("name, count(taggings.tag_id) as count").join(:taggings).group("taggings.tag_id")
  end
end
