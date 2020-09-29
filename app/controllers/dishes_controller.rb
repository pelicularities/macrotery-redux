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

    if params[:lat].nil? || params[:lng].nil? || params[:lat].empty? || params[:lng].empty?
      # lat and lng not given: check if request_location is valid
      # otherwise, default to Taman Jurong Shopping Centre
      user_location = request.location.nil? ? request_location : [1.33478625, 103.72010845018316]
    else
      # if lat and lng are given, use that as user_location
      # if user gives permission for location info, take user location using JS
      # and pass it in as query string
      user_location = [params[:lat], params[:lng]]
    end

    nearby_eateries = Eatery.near(user_location, 5)
    nearby_dishes = nearby_eateries.map(&:dishes).flatten

    @dishes = nearby_dishes.sort_by { |dish| calculate_score(@macro, dish) }.first(20)

    @eateries = []
    @dishes.each { |dish| @eateries << dish.eatery }
    @eateries.uniq!

    @markers = @eateries.select { |eatery| eatery.latitude.nil? == false }.map do |eatery|
      eatery_dishes = @dishes.select { |dish| dish.eatery == eatery }
      {
        lat: eatery.latitude,
        lng: eatery.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { eatery: eatery, eatery_dishes: eatery_dishes }, layout: false, formats: [:html])
      }
    end
    
    respond_to do |format|
      format.html {
        
      }
      format.json {
        html_content = render_to_string(partial: 'dishes/dishes_list', locals: { dishes: @dishes }, layout: false, formats: [:html])
        # map_content = render_to_string(partial: 'dishes/map', locals: { markers: @markers }, layout: false, formats: [:html])
        render json: { dishes: html_content, markers: @markers, macro: @macro }
      }
    end
  end

  def show
    @dish = Dish.find(params[:id]).include(:eatery)
    respond_to do |format|
      format.json { render json: { dish: @dish } }
    end
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
