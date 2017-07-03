class PostAttachment < ApplicationRecord
  belongs_to :post
  mount_uploader :attach, AttachUploader
  validates_processing_of :attach
  validate :attach_size_validation


  private
    def attach_size_validation
      errors[:attach] << "should be less than 1MB" if attach.size > 1.megabytes
    end
end
