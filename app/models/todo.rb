class Todo < ApplicationRecord
  # validation
  validates_presence_of :title, :order, :completed
end
