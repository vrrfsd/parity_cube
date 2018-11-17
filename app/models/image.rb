class Image < ApplicationRecord
	mount_uploader :pic, PicUploader
	belongs_to :album
	belongs_to :user
	scope :recent_images, -> { order("updated_at").reverse.last(25) }
end
