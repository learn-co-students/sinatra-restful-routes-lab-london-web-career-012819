require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # In the application_controller.rb, set up a controller action that will render a form to create a new recipe. This controller action should create and save this new recipe to the database.
  get '/recipes/new' do
    @recipe = Recipe.new
    erb :new
  end

  # Again in the application_controller.rb, create a controller action that uses RESTful routes to display a single recipe.
  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  # Create a controller action (index action) that displays all the recipes in the database. //ALL RECIPES INDEX
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # Create a third controller action that uses RESTful routes and renders a form to edit a single recipe. This controller action should update the entry in the database with the changes, and then redirect to the recipe show page. //EDITING
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    params.delete("_method")
    @recipe = Recipe.find(params[:id])
    # binding.pry
    @recipe.update(params)
    redirect "/recipes/#{@recipe.id}"
  end

  # Add to the recipe show page a form that allows a user to delete a recipe. This form should submit to a controller action that deletes the entry from the database and redirects to the index page.
  # add button to delete on the recipe show page.

  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect "/recipes"
  end

end
