namespace :currency_data do
  task fetch: :environment do |t, args|
    puts "Fetching data"

    start_date = Time.new(2014,1,1)
    end_date = Time.new(2014,12,25)

    while start_date < end_date
      date_string = start_date.strftime "%d%m%y"
      response = HTTParty.get("http://www.hnb.hr/tecajn/h#{date_string}.htm")

      if response.code == 200
        response.body.each_line do |line|
          Currency.all.each do |currency|
            if line.include?(currency.code) && line.upcase.include?(currency.name)
              line_components = line.split(/\s+/)
              sell = line_components[-1]
              middle = line_components[-2]
              buy = line_components[-3]
              unit = line_components[-4]
              rate = currency.rates.find_or_initialize_by date: start_date
              rate.assign_attributes unit: unit, sell: sell, buy: buy, mean: mean
              rate.save
            end
          end
        end
      end
      start_date += 1.day
    end
  end
end
