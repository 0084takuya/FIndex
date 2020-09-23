class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper
  include PlayersHelper
  include UsersHelper
end
