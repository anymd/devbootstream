class Boot < ActiveRecord::Base
  belongs_to :cohort
  has_many :resources
  has_many :posts, :through => :resources
  attr_accessible :name, :socrates_id
end
