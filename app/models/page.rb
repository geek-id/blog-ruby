class Page < ApplicationRecord
  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.counts
    self.select("name, count(taggings.tag_id) as count").join(:taggings).group("taggings.tag_id")
  end
end
