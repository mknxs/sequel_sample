require 'sequel'

DB = Sequel.sqlite

# create table
DB.create_table :users do
  primary_key :id
  String :name
  Date :birthday
end


# insert
User = DB[:users]
User.insert(name: 'Tanaka Taro', birthday: Date.strptime('2000/1/1', '%Y/%m/%d'))
User.insert(name: 'Yamada Hanako', birthday: Date.strptime('2003/2/2', '%Y/%m/%d'))

# all
User.all

# count
User.count

# find by id
User[id: 1]

# first record
User.first

# select column
User.select(:name)
User.select(:name, :birthday)
User.select(:name).select_append(:birthday)

# where
User.where(name: 'Tanaka Taro')
User.where(birthday: (Date.today - 1000)..(Date.today))
User.where(name: ['Tanaka Taro', 'Yamada Hanako'])
User.like(:name, '%Taro%')

# exclude
User.exclude(name: 'Tanaka Taro')

# prepared statement
User.where('name = ?', 'Yamada Hanako')

# order
User.order(:name)
User.reverse_order(:name)

# map
names = User.map(:name)
names.each { |n| puts n }

# arbitrary sql
DB['SELECT * FROM users'].each { |u| puts u[:name] }

# update record
User.where(name: 'Tanaka Taro').update(name: 'Yamada Taro')

# delete record
User.where(name: 'Tanaka Taro').delete


# TODO
# - transaction
# - join
# - sequel model
# - hooks
# - associations
# - eager loading
# - validation

