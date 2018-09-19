# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Monstruo.destroy_all
Tweet.destroy_all

Monstruo.create(nombre: "Dracula", descripcion: "Chupa sange")
Monstruo.create(nombre: "King Kong", descripcion: "Es un gorila gigante")
Monstruo.create(nombre: "Nahuelito", descripcion: "Vive en el Nahuel Huapi")
Monstruo.create(nombre: "Hombre lobo", descripcion: "Mitad lobo - mitad humano")

Tweet.create(estado: "Soy fanático de Walking Dead",monstruo: "Dracula")
Tweet.create(estado: "Se nadar espalda y mariposa desde que nací ",monstruo: "Dracula")
Tweet.create(estado: "La mona lisa es la mona más fea",monstruo: "King Kong")
Tweet.create(estado: "Soy un tipo con la sangre fría",monstruo: "Dracula")
Tweet.create(estado: "Me gusta el asado jugoso",monstruo: "Dracula")
Tweet.create(estado: "Fanático del Planeta de los Simios",monstruo: "King Kong")
Tweet.create(estado: "Destapo las latas con los dientes",monstruo: "Dracula")
Tweet.create(estado: "El ajo en la ensalada me cae mal",monstruo: "Dracula")