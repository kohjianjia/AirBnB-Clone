class Listing < ApplicationRecord

	belongs_to :user

	has_many :reservations, dependent: :destroy

	validates :title, presence: true
	validates :room_type, presence: true
	validates :city, presence: true
	validates :pricing, presence: true

	mount_uploaders :images, ImageUploader


	scope :search_city, -> (x) { where("city ILIKE ?", "%#{x}%") }
	scope :search_title, -> (y) { where("title ILIKE ?", "%#{y}%") }

end