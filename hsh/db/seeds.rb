# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Reestableciendo la base de datos'
Prop.destroy_all
Usuario.destroy_all
Reserva.destroy_all

#
# CREA PROPIEDADES (las crea gritando)
#

p = Prop.create(nombre:'Hotel sol bariloche',ubicacion:'Bariloche, Argentina',oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/hotelsol.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Hotel ausonia',ubicacion:'Bariloche, Argentina',oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/hotelausonia.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Rodeo ski',ubicacion:'Bariloche, Argentina',oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/rodeoski.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Shinta mani resort',ubicacion:'Siem reap, Cambodia',oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/shintamani.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Bellevue syrene',ubicacion:'Sorrento, Italia',oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/bellevue.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Hanoi hotel y spa',ubicacion:'Hanoi, Vietnam',oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/hanoi.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Achtis hotel',ubicacion:'Afitos, Grecia',oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/achtis.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Mirihi island resort',ubicacion:'Mirihi, Maldivas',oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/mirihi.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Bucuti & tara beach resort',ubicacion:'Eagle beach, Aruba',oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/bucuti.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Calabash luxury',ubicacion:'Saint Georges, Grenada',oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/calabash.jpeg'), filename: 'file.png')

p = Prop.create(nombre:'Hotel Ritta Hoppener',ubicacion:'Rio grande do sul, Brasil',oculto: false)
p.imgprincipal.attach(io: File.open('seedaux/ritta.jpeg'), filename: 'file.png')

#
# CREA USUARIOS (tambien grita)
#

Usuario.create(mail: 'jorge@yahoo.com')
Usuario.create(mail: 'raul@aol.com')
Usuario.create(mail: 'carlos@turbonet.com')
Usuario.create(mail: 'juan@hotmail.com')

#
# CREA RESERVAS
#

puts Usuario.where(mail: 'jorge')

Reserva.create(
	fecha: Date.new(2018, 11, 4),
	usuario_id: Usuario.where(mail: 'jorge@yahoo.com').first.id,
	prop_id: Prop.where('nombre like ?', '%Bucuti%').first.id )

Reserva.create(
	fecha: Date.new(2018, 11, 11),
	usuario_id: Usuario.where(mail: 'carlos@turbonet.com').first.id,
	prop_id: Prop.where('nombre like ?', '%Calabash%').first.id)

Reserva.create(
	fecha: Date.new(2018, 11, 18),
	usuario_id: Usuario.where(mail: 'juan@hotmail.com').first.id,
	prop_id: Prop.where('nombre like ?', '%Ritta%').first.id)

Reserva.create(
	fecha: Date.new(2018, 11, 18),
	usuario_id: Usuario.where(mail: 'juan@hotmail.com').first.id,
	prop_id: Prop.where('nombre like ?', '%Calabash%').first.id)

puts 'La base de datos fue reestablecida correctamente'
