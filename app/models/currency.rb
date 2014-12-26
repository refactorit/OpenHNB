class Currency < ActiveRecord::Base
  has_many :rates
end
