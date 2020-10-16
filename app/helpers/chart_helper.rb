module ChartHelper

  def chart_data(change_histories, default_price)
		data = []

		if change_histories.count == 0
			data.push(
				{
					x: 1.year.ago.strftime("%Y/%m/%d %H:%M:%S"),
					y: default_price
				}
			)
		else
			data.push(
				{
					x: 1.year.ago.strftime("%Y/%m/%d %H:%M:%S"),
					y: change_histories.first.new_value
				}
			)
		end

		change_histories.each do |history|
      # 1年より前であった場合
			continue if history.created_at < 1.year.ago.beginning_of_day
			
			data.push(
				{
					x: history.created_at.strftime("%Y/%m/%d %H:%M:%S"),
					y: history.new_value
				}
			)
		end

		data.push(
			{
				x: Time.now.strftime("%Y/%m/%d %H:%M:%S"),
				y: default_price
			}
		)
		
		data
	end

	def chart_option
		options = []

		options.push(format_option(1.days.ago))
		options.push(format_option(7.days.ago))
		options.push(format_option(1.months.ago))
		options.push(format_option(3.months.ago))
		options.push(format_option(6.months.ago))
		options.push(format_option(1.year.ago))

		options
	end

	def format_option(min_time)
		{
			min: min_time.strftime("%Y/%m/%d %H:%M:%S"),
			max: Time.now.strftime("%Y/%m/%d %H:%M:%S"),
		}
	end
end