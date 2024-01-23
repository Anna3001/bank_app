class HomeController < ApplicationController

    def index
    # Assuming you are using Devise and have the `authenticate_user!` before_action
    if signed_in?
        @combinations = current_user.combinations
    end
    end 

    def get_email
    end 
end


 