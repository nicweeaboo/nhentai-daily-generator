class User < ApplicationRecord
  validates :email,
  presence: true,
  uniqueness: { case_sensitive: false },
  length: { minimum: 4, maximum: 254 }  
end
