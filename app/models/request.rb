class Request < ApplicationRecord
    belongs_to :lead

    validates :annual_revenue, presence: true
    validates :entreprise_no, presence: true, length: { minimum: 10, maximum: 10 }
    validates :legal_name, presence: true, length: { maximum: 30 }
    #validates :natural_person, presence: true
    validates :nacebel_codes, presence: true, length: { minimum: 5}
end
