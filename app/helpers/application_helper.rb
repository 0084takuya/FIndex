module ApplicationHelper
    def page_title
        title = "FIndex"
        title = @page_title + "-" + title if @page_title
        title
    end

    def format_date(year, month, day)
        return Date.new(year.to_i, month.to_i, day.to_i) if Date.valid_date?(year.to_i, month.to_i, day.to_i)
        return Date.new(1899, 12, 31)
    end 
end