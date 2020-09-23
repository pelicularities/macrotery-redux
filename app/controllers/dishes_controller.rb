class DishesController < ApplicationController

  def index
    @user = current_user
    if params[:protein] && params[:carbs] && params[:fats]
      @macro = {
        protein: params[:protein].to_i,
        carbs: params[:carbs].to_i,
        fats: params[:fats].to_i
      }
      @macro[:calories] = 4 * @macro[:protein] + 4 * @macro[:carbs] + 9 * @macro[:fats]
    else
      @macro = @user.macros.sample  # just picking one, for testing purposes
    end

    @dish_scores = {}

    @dishes = Dish.all.sort_by { |dish| calculate_score(@macro, dish) }.first(20)

    @dishes.each do |dish|
      @dish_scores[dish] = calculate_score(@macro, dish)
    end

    respond_to do |format|
      format.html
      format.json { render json: { restaurants: @dishes } }
    end
  end

  def show
    @dish = Dish.find(params[:id])
  end

  private

  def calculate_score(user_macro, dish)
    # takes a Dish object, and either a Macro object or a hash with protein / carbs / fats keys
    # generates a score based on how close the proportions of the two sets of macros are
    # the closer to 0, the better the score

    protein_diff = (dish.protein - user_macro[:protein]).abs
    carbs_diff = (dish.carbs - user_macro[:carbs]).abs
    fats_diff = (dish.fats - user_macro[:fats]).abs

    protein_diff + carbs_diff + fats_diff * 4.0 / 9.0
  end

end
