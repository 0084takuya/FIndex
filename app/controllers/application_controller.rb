class ApplicationController < ActionController::Base
  include SessionsHelper
  include PlayersHelper
  include UsersHelper
end
