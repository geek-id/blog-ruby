class Page < ApplicationRecord
  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  
end
