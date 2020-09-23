class ProfilesController < ApplicationController
  before_action :find_profile


def calculate_macros
#should be boleen
# if yes, go to new
# if no, go to

end


def show
end


def edit
end

def update

end


private

def find_profile
  @user = current_user
end


end
