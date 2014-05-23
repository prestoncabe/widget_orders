require 'spec_helper'

feature 'Manage orders', js: true do
  scenario 'user sees correct fields on form' do
    visit new_order_path

    expect(page).to have_css 'input#order_quantity'
    expect(page).to have_css '[id*=order_color]'
    expect(page).to have_css 'input#order_date_needed_by'
    expect(page).to have_css '[id*=order_widget_type]'
  end

  scenario 'valid form submission results in persisted data' do
    visit new_order_path

    create_order(quantity: '4', color: 'Blue', date_needed_by: (Date.today + 7), widget_type: 'Widget')

    order = Order.first

    expect(order.quantity).to eq 4
    expect(order.color).to eq 'blue'
    expect(order.date_needed_by).to eq (Date.today + 7)
    expect(order.widget_type).to eq 'Widget'
  end

  scenario 'submission fails if any field is not completed' do
    visit new_order_path

    create_order(color: 'Blue', date_needed_by: '2014-07-20', widget_type: 'Widget Xtreme')
    create_order(quantity: '16', date_needed_by: (Date.today + 12), widget_type: 'Widget')
    create_order(quantity: '2', color: 'Yellow', widget_type: 'Widget Pro')
    create_order(quantity: '299486910586', color: 'Red', date_needed_by: (Date.today + 9))

    expect(Order.all.length).to eq 0
  end

  scenario 'submission fails if quantity entered is invalid' do
    visit new_order_path

    create_order(quantity: '-1', color: 'Yellow', date_needed_by: (Date.today + 106), widget_type: 'Widget')
    create_order(quantity: '0', color: 'Red', date_needed_by: (Date.today + 9), widget_type: 'Widget Xtreme')
    create_order(quantity: '23.4', color: 'Blue', date_needed_by: (Date.today + 60), widget_type: 'Widget Pro')

    expect(Order.all.length).to eq 0
  end

  scenario 'submission fails if date_needed_by entered is invalid' do
    visit new_order_path

    # bad
    create_order(quantity: '79854', color: 'Yellow', date_needed_by: (Date.today + 6), widget_type: 'Widget Xtreme')
    create_order(quantity: '984', color: 'Blue', date_needed_by: (Date.today + 3), widget_type: 'Widget Pro')

    # good
    create_order(quantity: '12', color: 'Red', date_needed_by: (Date.today + 7), widget_type: 'Widget')

    expect(Order.all.length).to eq 1
  end

  scenario 'successful submission displays a confirmation message' do
    visit new_order_path

    order = create_valid_order

    expect(page).to have_text "id: #{order.id}"
    expect(page).to have_text "quantity: #{order.quantity}"
    expect(page).to have_text "color: \"#{order.color}\""
    expect(page).to have_text "date_needed_by: \"#{order.date_needed_by}\""
    expect(page).to have_text "type: \"#{order.widget_type}\""
  end

  def create_order(options = {})
    within(:css, 'form#new_order') do
      fill_in 'Quantity', with: options.fetch(:quantity, '')
      choose options.fetch(:color) if options.include? :color
      fill_in 'Date needed by', with: options.fetch(:date_needed_by, '')
      choose options.fetch(:widget_type) if options.include? :widget_type

      click_button 'Create Order'
    end
  end

  def create_valid_order
    create_order(quantity: '12', color: 'Red', date_needed_by: (Date.today + 7), widget_type: 'Widget')
    Order.first
  end
end

