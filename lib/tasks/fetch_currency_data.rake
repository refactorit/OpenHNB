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
          if line.include?("840") && line.upcase.include?("USD")
            line_components = line.split(/\s+/)
            high = line_components[-1]
            middle = line_components[-2]
            low = line_components[-3]
            puts "#{low} #{middle} #{high}"
          end
        end
      end
      start_date += 1.day
    end
  end
end
