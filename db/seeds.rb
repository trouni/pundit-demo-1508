trouni = User.create!(email: 'trouni@me.com', password: '123123')
doug = User.create!(email: 'doug@me.com', password: '123123')

Restaurant.create!(name: 'Chuck E. Cheese', user: doug)
Restaurant.create!(name: 'Sukiya', user: trouni)
Restaurant.create!(name: 'McDonalds', user: trouni)
Restaurant.create!(name: 'Sushi Saito', user: doug)