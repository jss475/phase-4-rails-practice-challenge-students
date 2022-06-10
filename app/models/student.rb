class Student < ApplicationRecord
    validates :name, presence: true
    validates :major, presence: true
    validates :age, presence: true, numericality: {greater_than_or_equal_to: 18, only_integer: true}
    validates :instructor_id, presence: true, numericality: {only_integer: true}

    belongs_to :instructor
end
