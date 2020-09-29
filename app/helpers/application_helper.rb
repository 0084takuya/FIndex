module ApplicationHelper
    def page_title
        title = "FIndex"
        title = @page_title + "-" + title if @page_title
        title
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

    def user_bonus_point(user)
        bonus_points = BonusPoint.where(user_id: user.id)
        
        if bonus_points.nil?
            return 0
        end

        point = 0
        bonus_points.each do |bonus_point| 
            point += bonus_point.amount
        end

        return point
    end

    def user_total_point(user)
        user.point + user_bonus_point(user)
    end
end