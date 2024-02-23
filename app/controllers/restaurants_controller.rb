class RestaurantsController < ApplicationController
  # GET /restaurants or /restaurants.json
  def index
    @restaurants = policy_scope(Restaurant) # call the RestaurantPolicy::Scope#resolve method
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
    @restaurant = Restaurant.find(params[:id])

    # `authorize` in this context means "Is the user allowed to show the @restaurant"
    # it doesn't mean we are actually giving permission yet
    authorize @restaurant
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  # GET /restaurants/1/edit
  def edit
    @restaurant = Restaurant.find(params[:id])
    authorize @restaurant # whatever record we pass to the `authorize` will be accessible in the Policy under the `record` variable

    # Custom implementation (without pundit)
    # raise 'NotAuthorizedError' unless @restaurant.user == current_user
  end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant
    
    if @restaurant.save
      redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    @restaurant = Restaurant.find(params[:id])
    
    authorize @restaurant
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/1 or /restaurants/1.json
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy!

    redirect_to restaurants_url, notice: "Restaurant was successfully destroyed."
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:name)
    end
end
