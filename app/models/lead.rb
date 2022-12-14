class Lead < ApplicationRecord
    has_many :requests, dependent: :destroy

    # REGEX Inspired from https://mailtrap.io/blog/rails-email-validation/ 
    validates :email, presence: true,  format: { with: /\.(.+)@(.+)\z/}, length: { in: 4..254 }
    validates :phone, presence: true,  format: { with: /\A[+\d]+\z/}, length: { in: 7..16 }
    validates :firstname, presence: true, length: { in: 2..30 }
    validates :lastname, presence: true, length: { in: 2..30 }
    validates :address, presence: true, length: { in: 2..254 }

    validates_uniqueness_of :email, scope: [:phone]
end
