require_relative './lib/oystercard'

oyster = Oystercard.new

# oyster.top_up(86)
# oyster.deduct(80)
# p oyster.balance
#
# p oyster.touch_in
# p oyster.in_journey


oyster.top_up(0.5)
p oyster.touch_in







# Write a test that checks that the card has
#an empty list of journeys by default

# p oystercard.journey_history
#
# # Write a test that checks that touching in and out creates one journey
#
# p oystercard.top_up(5)
# p oystercard.touch_in("station_1")
# p oystercard.touch_out("station_2")
# p oystercard.journey_history
# p oystercard.balance
