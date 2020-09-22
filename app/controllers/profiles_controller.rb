class ProfilesController < ApplicationController
  before_action :find_profile


def calculate_macros
#should be boleen

end


def show

end

def create

end


def update

end


private

def find_profile
  @profile= Profile.find(params[:id])
end

end
