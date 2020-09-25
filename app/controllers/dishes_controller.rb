class DishesController < ApplicationController

  def index
    @user = current_user
    @macros = @user.macros
    
    if params[:macro].nil? == false && params[:macro].to_i.zero? == false
      @macro = Macro.find(params[:macro])
    elsif params[:protein] && params[:carbs] && params[:fats]
      @macro = {
        protein: params[:protein].to_i,
        carbs: params[:carbs].to_i,
        fats: params[:fats].to_i
      }
      @macro[:calories] = 4 * @macro[:protein] + 4 * @macro[:carbs] + 9 * @macro[:fats]
    else
      @macro = @user.macros.first  # default to first available macro
    end

    # user_location = [1.3060493499999999,103.8310084178641]  # will need to change this later, to get actual user location
    user_location = request.location
    nearby_eateries = Eatery.near(user_location, 5)
    nearby_dishes = nearby_eateries.map(&:dishes).flatten

    @dishes = nearby_dishes.sort_by { |dish| calculate_score(@macro, dish) }.first(20)

    # what happens if no dishes match this condition?
    # view needs to fail nicely

    respond_to do |format|
      format.html {
        @eateries = []
        @dishes.each { |dish| @eateries << dish.eatery }
        @eateries.uniq!

        @markers = @eateries.select { |eatery| eatery.latitude.nil? == false }.map do |eatery|
          eatery_dishes = @dishes.select { |dish| dish.eatery == eatery }
          {
            lat: eatery.latitude,
            lng: eatery.longitude,
            infoWindow: render_to_string(partial: "info_window", locals: { eatery: eatery, eatery_dishes: eatery_dishes })
          }
        end
      }
      format.json { render json: { dishes: @dishes } }
    end
  end

  def show
    @dish = Dish.find(params[:id])
  end

  private

  def calculate_score(user_macro, dish)
    # takes a Dish object, and either a Macro object or a hash with protein / carbs / fats keys
    # generates a score based on how close the two sets of macros are
    # the closer to 0, the better the score

    protein_diff = (dish.protein - user_macro[:protein]).abs
    carbs_diff = (dish.carbs - user_macro[:carbs]).abs
    fats_diff = (dish.fats - user_macro[:fats]).abs

    protein_diff + carbs_diff + fats_diff * 4.0 / 9.0
  end

end
