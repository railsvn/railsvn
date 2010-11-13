def create_admin
  puts 'Creating admin...'
  admin_user = User.find_or_create_by_email('admin@railsvn.com')
  admin_user.password = 'letmein'
  admin_user.admin = true
  admin_user.display_name = 'Super Admin'
  admin_user.save!
end

create_admin
