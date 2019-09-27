# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)



#Userlevel.create(id: 1, name: 'user') 
#admin_ul = Userlevel.create(id: 2, name: 'admin') 
#Userlevel.create(id: 3, name: 'usertabel') 
#Userlevel.create(id: 4, name: 'alltabeluser')

Userlevel.where(id: 1).first_or_create( name: 'user') 
admin_ul = Userlevel.where(id: 2).first_or_create( name: 'admin') 
Userlevel.where(id: 3).first_or_create( name: 'usertabel') 
Userlevel.where(id: 4).first_or_create( name: 'alltabeluser') 
Userlevel.where(id: 5).first_or_create( name: 'driver') 
Userlevel.where(id: 6).first_or_create( name: 'сompany_admin')
Userlevel.where(id: 7).first_or_create( name: 'only_login')
Userlevel.where(id: 8).first_or_create( name: 'director')

aauto=Aauto.where( id: 6).first_or_create (
  {name: 'no auto',
  autodesc: 'no auto',
  autonumber: 'no auto',
  contact: 'no auto'}
)

company=Company.where( id: 1).first_or_create(
	name: 'Company1',
	istabelling: true
)

User.where(name: 'admin').destroy_all
unless User.create(
	email: 'siafin2010@gmail.com',
	name: 'admin',
	userlevel: admin_ul,	
	company: company,
	password: '120880'
) 
then 
	raise 'user not created blyat'
end
