Factory.define :user do |f|
  f.display_name "Display Name"
  f.sequence(:email) { |n| "some.one#{n}@example.com" }
  f.password "secret"
end

Factory.define :admin_user, :parent => :user do |f|
  f.sequence(:email) { |n| "admin#{n}@example.com" }
  f.admin true
end
