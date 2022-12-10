class AddLeadToRequests < ActiveRecord::Migration[7.0]
  def change
    add_reference :requests, :lead, foreign_key: true
  end
end
