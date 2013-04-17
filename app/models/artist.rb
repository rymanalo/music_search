class Artist < ActiveRecord::Base
  attr_accessible :favorite, :name, :user_id

  belongs_to :user
end
