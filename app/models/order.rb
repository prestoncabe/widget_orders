class Order < ActiveRecord::Base

  validates_numericality_of :quantity,
    greater_than: 0,
    only_integer: true,
    message: 'must be a positive integer'

  validates_inclusion_of :color,
    :in => %w(red blue yellow),
    message: 'must be red, blue, or yellow'

  validates_inclusion_of :date_needed_by,
    :in => (Date.today + 7)..Date.parse('2099-12-31'), # TODO: is there a better way to do this?
    message: 'must be at least 7 days from today'

  validates_inclusion_of :widget_type,
    :in => ['Widget', 'Widget Pro', 'Widget Xtreme'],
    message: 'must be Widget, Widget Pro, or Widget Xtreme'

end
