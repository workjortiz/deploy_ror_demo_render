class CreateChallenges < ActiveRecord::Migration[7.2]
  def change
    create_table :challenges do |t|
      t.string :name
      t.string :country
      t.string :original_content
      t.string :parsing_content
      t.string :token

      t.timestamps
    end
  end
end
