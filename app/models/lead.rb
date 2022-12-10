class Lead < ApplicationRecord
    validates :email, presence: true, length: { maximum: 40 }
    validates :phone, presence: true, length: { maximum: 20 }
    validates :firstname, presence: true, length: { maximum: 30 }
    validates :lastname, presence: true, length: { maximum: 30 }
    validates :address, presence: true, length: { maximum: 40 }
    validates_uniqueness_of :email, scope: [:phone]
end
