namespace :currency_data do
  task fetch: :environment do |t, args|
    puts "Fetching data"
    response = HTTParty.get('http://www.hnb.hr/tecajn/h251214.htm')

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
end
