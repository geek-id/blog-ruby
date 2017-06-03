class CreatePostAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :post_attachments do |t|
      t.string :attach
      # t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
