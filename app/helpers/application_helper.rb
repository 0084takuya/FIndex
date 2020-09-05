module ApplicationHelper
    def page_title
        title = "FIndex"
        title = @page_title + "-" + title if @page_title
        title
    end
end
