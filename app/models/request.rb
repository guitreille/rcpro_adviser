class Request < ApplicationRecord
    belongs_to :lead
    has_one :quote, dependent: :destroy

    validates :annual_revenue, presence: true, numericality: true
    validates :entreprise_no, presence: true, length: { is: 10}
    validates :legal_name, presence: true, length: { in: 1..30 }
    validates :natural_person, presence: true
    validates :nacebel_codes, presence: true, length: { minimum: 5}
end
