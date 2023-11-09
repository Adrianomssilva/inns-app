class Price < ApplicationRecord
  belongs_to :room

  private

  # def range_validate
  #   range = Range.new(self.date_start, self.date_end)
  #   room = self.room
  #   room.prices.each do |price|
  #     range2 = Range.new(price.date_start, price.date_end)
  #     if range.overlap?range2
  #       errors.add()
  #     end
  #   end

  # end
end
