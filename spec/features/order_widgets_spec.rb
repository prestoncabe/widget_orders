require 'spec_helper'

feature 'User creates orders', js: true do
  scenario 'form has correct fields' do
    visit new_order_path

    expect(page).to have_css 'input#order_quantity'
    expect(page).to have_css '[id*=order_color]'
    expect(page).to have_css 'input#order_date_needed_by'
    expect(page).to have_css '[id*=order_widget_type]'
  end

  scenario 'form submission results in persisted data' do
    visit new_order_path

    within(:css, 'form#new_order') do
      fill_in 'Quantity', with: 4
      choose 'Blue'
      fill_in 'Date needed by', with: '2014-06-01'
      choose 'Widget Xtreme'

      click_button 'Create Order'
    end

    order = Order.first

    expect(order.quantity).to eq 4
    expect(order.color).to eq 'blue'
    expect(order.date_needed_by).to eq Date.parse('2014-06-01')
    expect(order.widget_type).to eq 'Widget Xtreme'
  end
end

