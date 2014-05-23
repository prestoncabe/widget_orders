class Order < ActiveRecord::Base
  validates :quantity, :color, :date_needed_by, :widget_type, presence: true
end
