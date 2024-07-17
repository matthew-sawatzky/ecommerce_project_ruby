

# Seed admin user
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Seed provinces
Province.create!([
  { province_name: 'Alberta', provincial_tax: 0, federal_tax: 5 },
  { province_name: 'British Columbia', provincial_tax: 7, federal_tax: 5 },
  { province_name: 'Manitoba', provincial_tax: 7, federal_tax: 5 },
  { province_name: 'New Brunswick', provincial_tax: 10, federal_tax: 5 },
  { province_name: 'Newfoundland and Labrador', provincial_tax: 10, federal_tax: 5 },
  { province_name: 'Northwest Territories', provincial_tax: 0, federal_tax: 5 },
  { province_name: 'Nova Scotia', provincial_tax: 10, federal_tax: 5 },
  { province_name: 'Nunavut', provincial_tax: 0, federal_tax: 5 },
  { province_name: 'Ontario', provincial_tax: 8, federal_tax: 5 },
  { province_name: 'Prince Edward Island', provincial_tax: 10, federal_tax: 5 },
  { province_name: 'Quebec', provincial_tax: 9.975, federal_tax: 5 },
  { province_name: 'Saskatchewan', provincial_tax: 6, federal_tax: 5 },
  { province_name: 'Yukon', provincial_tax: 0, federal_tax: 5 }
])
