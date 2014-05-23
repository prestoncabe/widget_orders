class Order < ActiveRecord::Base
  validates :widget_type, presence: true

  validates_numericality_of :quantity, greater_than: 0, only_integer: true

  validates_inclusion_of :color,
    :in => %w(red blue yellow)

  validates_inclusion_of :date_needed_by,
    :in => (Date.today + 7)..Date.parse('2099-12-31') # TODO: is there a better way to do this?

end
