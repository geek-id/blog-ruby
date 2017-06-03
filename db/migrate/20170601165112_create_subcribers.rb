class CreateSubcribers < ActiveRecord::Migration[5.0]
  def change
    create_table :subcribers do |t|
      t.string :name
      t.string :email, unique: true

      t.timestamps
    end
  end
end
