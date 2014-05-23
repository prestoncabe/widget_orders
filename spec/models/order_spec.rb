require 'spec_helper'

describe Order do
  it {
    should ensure_inclusion_of(:color).
    in_array %w(red blue yellow)
  }
end
