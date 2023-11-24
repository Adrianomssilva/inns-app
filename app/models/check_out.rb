class CheckOut < ApplicationRecord
  belongs_to :reservation, optional: true





  def generate_total
      reservation = self.reservation if reservation.present?
      tempo_checkout_inn = reservation.room.inn.check_out.hour*60 + reservation.room.inn.check_out.min
      tempo_checkout = Time.now.hour*60 + Time.now.min

      range = (self.start_date...self.end_date).to_a
      room = self.room
      prices_ar = []
      range.each do |date|
        presence = false
        room.prices.each do |price|
          if date.between?(price.date_start, price.date_end)
            presence = true
            prices_ar << price.value.to_i
            break
          end
          end
        if presence != true
            prices_ar << room.default_price.to_i
        end
          self.total_value = prices_ar.sum
    end
  end
end
