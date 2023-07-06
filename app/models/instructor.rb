class Instructor < ApplicationRecord
    has_many :students, dependent: :destroy
    validates :name, presence: true
    validates :name, uniqueness: true
end
