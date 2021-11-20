class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def pastbookings
    policy_scope(Booking)
  end
end
