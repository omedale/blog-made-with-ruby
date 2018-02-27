class CategoriesController < ApplicationController

  def index
    @categories = Category.all
    puts @categories
  end

  def new

  end

  def create
    Category.create!(name: params[:name])
    redirect_to categories_path
  end

  def show

  end

end
