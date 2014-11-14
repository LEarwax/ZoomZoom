class Driver < ActiveRecord::Base
  has_many  :ownerships
  has_many  :cars, through: :ownerships
end
