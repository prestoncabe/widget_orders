class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.string :color
      t.date :date_needed_by
      t.string :widget_type
    end
  end
end
