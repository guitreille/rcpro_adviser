class CreateLeads < ActiveRecord::Migration[7.0]
  def change
    create_table :leads do |t|
      t.string :email
      t.string :phone
      t.string :address
      t.string :firstname
      t.string :lastname

      t.timestamps
    end

    add_index :leads, [:email, :phone], :unique=> true
  end
end
