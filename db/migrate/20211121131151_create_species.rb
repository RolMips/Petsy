class CreateSpecies < ActiveRecord::Migration[6.1]
  def change
    create_table :species do |t|
      t.string :name
      t.string :slug
      t.integer :pets_count
      t.timestamps
    end
  end
end
