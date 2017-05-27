class Enrollment < ApplicationRecord
  belongs_to :student, class_name: 'Person', foreign_key: 'person_id'
  belongs_to :course

  validates :student, presence: true
  validates :course, presence: true


  accepts_nested_attributes_for :student
  accepts_nested_attributes_for :course
end
