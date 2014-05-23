require 'spec_helper'

describe Order do
  it {
    should ensure_inclusion_of(:color).
    in_array %w(red blue yellow)
  }

  it {
    should ensure_inclusion_of(:widget_type).
    in_array ['Widget', 'Widget Pro', 'Widget Xtreme']
  }
end
