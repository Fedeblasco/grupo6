# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Reestableciendo la base de datos'
Prop.destroy_all
Prop.create(nombre:'Hotel sol bariloche',ubicacion:'Bariloche, Argentina');
Prop.create(nombre:'Hotel ausonia',ubicacion:'Bariloche, Argentina')
Prop.create(nombre:'Rodeo ski',ubicacion:'Bariloche, Argentina')
Prop.create(nombre:'Shinta mani resort',ubicacion:'Siem reap, Cambodia')
Prop.create(nombre:'Bellevue syrene',ubicacion:'Sorrento, Italia')
Prop.create(nombre:'Hanoi hotel y spa',ubicacion:'Hanoi, Vietnam')
Prop.create(nombre:'Achtis hotel',ubicacion:'Afitos, Grecia')
Prop.create(nombre:'Mirihi island resort',ubicacion:'Mirihi, Maldivas')
Prop.create(nombre:'Bucuti & tara beach resort',ubicacion:'Eagle beach, Aruba')
Prop.create(nombre:'Calabash luxury',ubicacion:'Saint Georges, Grenada')
Prop.create(nombre:'Hotel Ritta Hoppener',ubicacion:'Rio grande do sul, Brasil')
puts 'La base de datos fue reestablecida correctamente'
