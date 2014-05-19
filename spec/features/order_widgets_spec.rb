require 'spec_helper'

feature 'User creates orders', js: true do
  scenario 'form has correct fields' do
    visit new_order_path

    expect(page).to have_css 'input#order_quantity'
    expect(page).to have_css '[id*=order_color]'
    expect(page).to have_css 'input#order_date_needed_by'
    expect(page).to have_css '[id*=order_widget_type]'
  end
end

