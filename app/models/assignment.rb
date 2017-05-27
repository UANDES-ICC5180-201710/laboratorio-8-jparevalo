class Assignment < ApplicationRecord
  belongs_to :course

  validates :title, length: { minimum: 3,  maximum: 30 }, presence: true
  validates :statement, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  def to_s
    return title
  end
end
