class CheckOut < ApplicationRecord
  belongs_to :reservation, optional: true




  def self.total_calculate(reservation, exit)
    room = reservation.room
    inn_check_out = room.inn.check_out.hour*60 + room.inn.check_out.min
    check_out = exit.hour*60 + exit.min
    entry = reservation.check_in.entry.to_date
    exit_true = exit.to_date
    exit_true2 = exit.to_date + 1.day

    binding.break

    if inn_check_out < check_out
    calculate( entry, exit_true2)
    # else
    # calculate(room, entry, exit_true2)
    end
  end

  def calculate(room, entry, exit)
    range = (entry...exit).to_a
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
          return prices_ar.sum
      end
  end


  private
end
