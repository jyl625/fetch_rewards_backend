# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# test
Point.create("payer": "DANNON", "points": 1000, "timestamp": "2020-11-02T14:00:00Z")
Point.create("payer": "UNILEVER", "points": 200, "timestamp": "2020-10-31T11:00:00Z")
Point.create("payer": "DANNON", "points": -200, "timestamp": "2020-10-31T15:00:00Z")
Point.create("payer": "MILLER COORS", "points": 10000, "timestamp": "2020-11-01T14:00:00Z")
Point.create("payer": "DANNON", "points": 300, "timestamp": "2020-10-31T10:00:00Z")
Point.create("payer": "TEST", "points": 0, "timestamp": "2020-10-30T10:00:00Z")