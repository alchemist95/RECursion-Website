class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :college
      t.integer :role
      t.string :batch
      t.string :dept
      t.string :image_url
      t.string :nickname
      t.date :dob

      t.timestamps
    end
  end
end
