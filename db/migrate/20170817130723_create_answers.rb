class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :description
      t.integer :likes

      t.timestamps
    end
  end
end
