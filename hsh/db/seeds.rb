# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Reestableciendo la base de datos'
Prop.destroy_all

p = Prop.create(nombre:'Hotel sol bariloche',ubicacion:'Bariloche, Argentina',capacidad: 5,oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/hotelsol.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Hotel ausonia',ubicacion:'Bariloche, Argentina',capacidad: 5,oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/hotelausonia.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Rodeo ski',ubicacion:'Bariloche, Argentina',capacidad: 5,oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/rodeoski.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Shinta mani resort',ubicacion:'Siem reap, Cambodia',capacidad: 5,oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/shintamani.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Bellevue syrene',ubicacion:'Sorrento, Italia',capacidad: 5,oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/bellevue.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Hanoi hotel y spa',ubicacion:'Hanoi, Vietnam',capacidad: 5,oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/hanoi.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Achtis hotel',ubicacion:'Afitos, Grecia',capacidad: 5,oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/achtis.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Mirihi island resort',ubicacion:'Mirihi, Maldivas',capacidad: 5,oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/mirihi.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Bucuti & tara beach resort',ubicacion:'Eagle beach, Aruba',capacidad: 5,oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/bucuti.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Calabash luxury',ubicacion:'Saint Georges, Grenada',capacidad: 5,oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/calabash.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Hotel Ritta Hoppener',ubicacion:'Rio grande do sul, Brasil',capacidad: 5,oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/ritta.jpeg'), filename: 'file.png')

puts 'La base de datos fue reestablecida correctamente'