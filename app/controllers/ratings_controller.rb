class RatingsController < ApplicationController
  before_action :find_product
  def create
    @rating = @product.ratings.find_or_create_by(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.json { render json: {rating: @rating} }
    end
  end

  def destroy
    @rating = @product.ratings.where(user_id: current_user.id).destroy_all
    respond_to do |format|
      format.html
      format.json { render json: {rating: @rating} }
    end
  end


  private

  def find_product
    @product = Product.find(params[:product_id])
  end
end
