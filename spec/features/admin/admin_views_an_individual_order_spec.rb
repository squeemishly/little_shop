require 'rails_helper'

RSpec.describe "visit individual order" do
  context "as admin" do
    it "views details of an order" do
      admin = create(:user, role: 1)
      user = create(:user)
      item = create(:item)
      order1 = create(:order, user_id: user.id)
      OrderItem.create(item_id: item.id, order_id: order1.id, quantity: 1, price_at_purchase: 100.00)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path
      click_on "Order #{order1.id}, #{order1.user.username}"
      expect(current_path).to eq(user_order_path(user, order1))

      expect(page).to have_content order1.user.username
      expect(page).to have_content("Date: #{order1.created_at.to_date}")
      expect(page).to have_content("Time: #{order1.created_at.strftime("%I:%M%p")}")
      expect(page).to have_content("Purchaser: #{order1.user.first_name} #{order1.user.last_name}")
      expect(page).to have_content("Address: #{order1.user.address}, #{order1.user.city}, #{order1.user.state}, #{order1.user.zipcode}")

      page.has_css?("th", text: "Items")
      page.has_css?("th", text: "Quantity")
      page.has_css?("th", text: "Price")
      page.has_css?("th", text: "Subtotal")

      page.has_css?("td", text: order1.items.first.title)
      page.has_css?("td", text: item.get_quantity(order1))
      page.has_css?("td", text: item.price)
      page.has_css?("td", text: "$100.00")

      expect(page).to have_content "Total: $100.00"
      expect(page).to have_content "Status: #{order1.status}"
    end

    it "views details of an order" do
      admin = create(:user, role: 1)
      user = create(:user)
      item = create(:item)
      item2 = create(:item)
      order1 = create(:order, user_id: user.id)
      OrderItem.create(item_id: item.id, order_id: order1.id, quantity: 1, price_at_purchase: 100.00)
      OrderItem.create(item_id: item2.id, order_id: order1.id, quantity: 2, price_at_purchase: 100.00)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "admin/dashboard" #new_admin_item_path
      click_on "Order #{order1.id}, #{order1.user.username}"
      expect(current_path).to eq(user_order_path(user, order1))

      expect(page).to have_content order1.user.username
      expect(page).to have_content("Date: #{order1.created_at.to_date}")
      expect(page).to have_content("Time: #{order1.created_at.strftime("%I:%M%p")}")
      expect(page).to have_content("Purchaser: #{order1.user.first_name} #{order1.user.last_name}")
      expect(page).to have_content("Address: #{order1.user.address}, #{order1.user.city}, #{order1.user.state}, #{order1.user.zipcode}")

      page.has_css?("th", text: "Items")
      page.has_css?("th", text: "Quantity")
      page.has_css?("th", text: "Price")
      page.has_css?("th", text: "Subtotal")

      page.has_css?("td", text: order1.items.first.title)
      page.has_css?("td", text: item.get_quantity(order1))
      page.has_css?("td", text: item.price)
      page.has_css?("td", text: "$100.00")

      expect(page).to have_content "Total: $300.00"
      expect(page).to have_content "Status: #{order1.status}"
    end
  end
end
