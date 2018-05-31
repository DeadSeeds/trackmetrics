class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events

  validates :name, length: { minimum: 3, maximum: 254 }, presence: true, uniqueness: { case_sensitive: false }
  validates :url, length: {minimum: 4, maximum: 254 }, presence: true, uniqueness: { case_sensitive: false }
end
