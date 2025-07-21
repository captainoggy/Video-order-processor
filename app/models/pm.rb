class Pm < ApplicationRecord
  has_many :projects
  has_many :notifications
end
