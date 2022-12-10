class CreateQuotes < ActiveRecord::Migration[7.0]
  def change
    create_table :quotes do |t|
      t.boolean :available
      t.integer :coverage_ceiling
      t.integer :deductible
      t.string :api_quote_id, unique: true
      t.string :gross_premiums

      t.timestamps
    end
    add_reference :quotes, :request, foreign_key: true
  end
end
