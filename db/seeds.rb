# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Genre.destroy_all
Instrument.destroy_all

g1 = Genre.create(name: "Jazz")
g2 = Genre.create(name: "Rock")
g3 = Genre.create(name: "Metal")
g4 = Genre.create(name: "Blues")
g5 = Genre.create(name: "Country")
g6 = Genre.create(name: "Punk")
g7 = Genre.create(name: "Indie")
g8 = Genre.create(name: "Pop")
g9 = Genre.create(name: "Funk")
g10 = Genre.create(name: "Ska")

i1 = Instrument.create(name: "Mic (Singer)")
i2 = Instrument.create(name: "Guitar")
i3 = Instrument.create(name: "Bass")
i4 = Instrument.create(name: "Drums")
i5 = Instrument.create(name: "Keyboard")
i6 = Instrument.create(name: "Harmonica")
i7 = Instrument.create(name: "Trumpet")
i8 = Instrument.create(name: "Violin")

