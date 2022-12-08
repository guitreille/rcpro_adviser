class CreateSimulations < ActiveRecord::Migration[7.0]
  def change
    create_table :simulations do |t|
      t.integer :annual_revenue
      t.string :entreprise_no
      t.string :legal_name
      t.boolean :natural_person
      t.string :nacebel_codes

      t.timestamps
    end
  end
end
