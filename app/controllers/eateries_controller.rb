class EateriesController < ApplicationController

    def show
        @eatery = Eatery.find(params[:id])
    end
end
