class RecipesController < ApplicationController
    
    def index
      @recipes = Recipe.paginate(page: params[:page], per_page: 5)
    end
    
    def show
      @recipe = Recipe.find(params[:id])  
    end
    
    def new
      @recipe = Recipe.new
    end
    
    def create
      @recipe = Recipe.new(recipe_params)
      @recipe.chef = Chef.first
      if @recipe.save
        flash[:success] = "Recipe was created"
        redirect_to recipe_path(@recipe)
      else
        render 'new'
      end
    end
    
    def edit
      @recipe = Recipe.find(params[:id])
    end
    
    def update
      @recipe = Recipe.find(params[:id])
      if @recipe.update(recipe_params)
        flash[:success] = "Recipe was updated"
        redirect_to recipe_path(@recipe)
      else
        render 'edit'
      end
    end
    
    def destroy
      Recipe.find(params[:id]).destroy
      flash[:success] = "Recipe deleted"
      redirect_to recipes_path
    end
    
    private
    
    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end
end