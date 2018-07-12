class Reservation < ApplicationRecord

	belongs_to :user
	belongs_to :listing

	validate :check_dates

	validates_presence_of :start_date, :end_date
	validate :end_date_is_after_start_date

	validate :overlapping_reservations

	before_save :calculate_total_price

	def check_dates
	    if start_date.present? && start_date < Date.today
	    	errors.add(:check_in, "date can't be in the past!")
	    end
	end

	def end_date_is_after_start_date
		return if end_date.blank? || start_date.blank?

		if end_date < start_date
			errors.add(:end_date, "cannot be before the start date.") 
		end 
	end

	# Check if a given reservation overlaps this interval
	def overlapping_reservations
		# byebug
		# =? prevents sql injection
		Reservation.where("listing_id =?", self.listing_id).each do |r|
			if overlaps?(r)
				return errors.add(:unavailable, "dates!")
			end
		end
	end

	def calculate_total_price
		# byebug
		self.total_price = self.listing.pricing * (self.end_date - self.start_date).to_i
	end

	private	
	# Check if a given reservation overlaps this reservation    
	def overlaps?(other)
		self.start_date <= other.end_date && other.start_date <= self.end_date
	end

end










