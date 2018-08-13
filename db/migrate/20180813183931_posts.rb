class Posts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :post_id
      t.string :title
      t.string :image
      t.text :content
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :user_id
    end
  end
end
