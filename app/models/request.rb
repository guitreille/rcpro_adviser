class Request < ApplicationRecord
    validates :annual_revenue, presence: true
    validates :entreprise_no, presence: true, length: { maximum: 30 }
    validates :legal_name, presence: true, length: { maximum: 30 }
    #validates :natural_person, presence: true
    #validates :nacebel_codes, presence: true
end
