class AddCompositeKeyToLeads < ActiveRecord::Migration[7.0]
  def change
    add_index :leads, [:email, :phone], :unique=> true
  end
end
