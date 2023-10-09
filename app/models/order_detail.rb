class OrderDetail < ApplicationRecord
  validates :product_name, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true 
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :order_date,presence: true
end
