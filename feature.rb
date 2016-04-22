require './lib/oystercard.rb'
require './lib/station.rb'

oyster = Oystercard.new
oyster.top_up(Oystercard::DEFAULT_LIMIT)

aldgate = Station.new("aldgate",1)
battersea = Station.new("battersea",3)

p oyster.balance
p oyster.journeys

oyster.touch_in(aldgate)
oyster.touch_out(battersea)
p oyster.balance
p oyster.journeys

oyster.touch_in(aldgate)
oyster.touch_in(aldgate)
p oyster.balance
p oyster.journeys

p oyster.in_journey?
oyster.touch_out(battersea)

p oyster.balance
p oyster.journeys

p oyster.in_journey?
oyster.touch_out(battersea)

p oyster.balance
p oyster.journeys
