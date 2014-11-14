class Car < ActiveRecord::Base
  has_many :ownerships
  has_many :drivers, through: :ownerships
end
