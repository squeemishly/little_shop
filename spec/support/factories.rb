FactoryGirl.define do

  factory :category do
    name

    factory :category_with_items do
      transient do
        items_count 5
      end

      after(:create) do |category, evaluator|
        category.items << create_list(:item, evaluator.items_count)
      end
    end
  end

  sequence :name do |n|
    "category_#{n}"
  end

  factory :item do
    title
    description 'Made in the Universe Space Area'
    price 100.00
    # image
    status 0
  end

  sequence :title do |n|
    "item_#{n}"
  end

  factory :user do
    role 0
    sequence :username do |n|
      "user_#{n}"
    end
    sequence :email do |n|
      "meatball_lover_#{n}@puppy"
    end
    password 'meatball'
    address '2020 Lawrence st'
    first_name 'Zuzu'
    last_name 'Thomas'
    state 'CO'
    city 'Denver'
    zipcode '80205'

    factory :user_with_orders do
      transient do
        orders_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:order, evaluator.orders_count, user: user)
      end
    end

    factory :user_with_order_with_items do
      transient do
        orders_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:order_with_items, evaluator.orders_count, user: user)
      end
    end
  end

  factory :order do
    status 0
    user
    # item 3

    factory :order_with_items do
      transient do
        items_count 5
      end

      after(:create) do |order, evaluator|
        order.items << create_list(:item, evaluator.items_count)
      end
    end
  end


end
