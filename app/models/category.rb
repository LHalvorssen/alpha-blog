class Category < ApplicationRecord
    validates :name, presence: true, length: {minimum: 3, maximum: 20}
    validates_uniqueness_of :name
    validates :description, presence: true, length: {minimum: 3, maximum: 280}

end