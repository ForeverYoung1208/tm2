# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Userlevel.create(id: 1, name: 'user') 
Userlevel.create(id: 2, name: 'admin') 
Userlevel.create(id: 3, name: 'usertabel') 
Userlevel.create(id: 4, name: 'alltabeluser')


adriver=Adriver.new(
  name: 'no driver6',
  autodesc: 'no auto',
  autonumber: 'no auto',
  contact: 'no driver'
)
adriver.id=6
adriver.save
