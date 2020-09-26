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

    def player_image(image_name)
        return image_tag "system/person", class: "rounded-img" if image_name == "" 
        
        image_path = "player/#{image_name}.jpg"
        if File.exist? "#{Rails.root}/app/assets/images/player/#{image_name}.jpg"
            return image_tag image_path, class: "rounded-img"
        else
            return image_tag "system/person", class: "rounded-img"
        end
    end

    def plus_minus_delta(delta)
        if delta > 0 
            return content_tag(:p, "+" + delta.to_s, class: "plus-delta")
        elsif delta == 0
            return content_tag(:p, delta.to_s, class: "equal-delta")
        else
            return content_tag(:p, delta.to_s, class: "minus-delta")
        end
    end
end