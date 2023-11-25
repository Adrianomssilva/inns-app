class CheckOut < ApplicationRecord
  belongs_to :reservation




  def self.total_calculate(reservation, exit)
    room = reservation.room
    inn_check_out = room.inn.check_out.hour*60 + room.inn.check_out.min
    check_out = exit.hour*60 + exit.min
    entry = reservation.check_in.entry.to_date
    exit_true = exit.to_date
    range1 = (entry...exit_true).to_a
    range2 = (entry..exit_true).to_a
    prices_ar = []
    if inn_check_out < check_out
      range1.each do |date|
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
      end
    elsif inn_check_out >= check_out
      range2.each do |date|
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
      end
    end
    prices_ar.sum
  end




  private
end
