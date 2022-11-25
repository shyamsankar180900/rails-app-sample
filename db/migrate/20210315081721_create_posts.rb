class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :content
      t.references :user
      t.integer :likes, default: 0

      t.timestamps
    end
  end
end
