class Order < ActiveRecord::Base
  validates :color, :date_needed_by, :widget_type, presence: true

  validates_numericality_of :quantity, greater_than: 0, only_integer: true
end
