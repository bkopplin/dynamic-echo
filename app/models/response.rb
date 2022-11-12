class Response < ApplicationRecord

  validates :code, presence: true
  validates :headers, presence: false
  validates :body, presence: true

end
