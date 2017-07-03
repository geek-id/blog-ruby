class Post < ApplicationRecord
  belongs_to :user
  has_many :post_attachment
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :descriptions, presence: true, length: {maximum: 200}
  mount_uploader :images, ImageUploader
  validates_processing_of :images
  validate :images_size_validation
  extend FriendlyId
  friendly_id :title, use: :slugged

  after_create :send_email_to_subscribers

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.counts
    self.select("name, count(taggings.tag_id) as count").join(:taggings).group("taggings.tag_id")
  end

  private
    def images_size_validation
      errors[:images] << "should be less than 5MB" if images.size > 5.megabytes
    end

    def send_email_to_subscribers
      Subcriber.all.each do |subscriber|
        SubscriptionMailer.send_email(subscriber.email, self)
      end
    end
end
