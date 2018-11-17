class Album < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images

end
