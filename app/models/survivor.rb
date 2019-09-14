class Survivor < ApplicationRecord
    has_many :denunciations
    

    validates :description, length: { in: 2..50 }
    validates :age, numericality: { only_integer: true }
    validates :sex, presence: true
end
