class Org < ActiveRecord::Base
  validates :name,presence:true,length:{in: 5..20}
  validates :description, presence:true,length:{in: 10..50}
  
  belongs_to :user
  has_many :manies
  has_many :users, through: :manies
end
