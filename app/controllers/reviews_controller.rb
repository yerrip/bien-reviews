class ReviewsController < ApplicationController

  # check if logged in

  before_action :check_login, except: [:index, :show]


    def index
      #this is our list page for reviews

      @price = params[:price]
      @cuisine = params[:cuisine]
      @location = params[:location]

      #start with all the reviews
      @reviews = Review.all

      #filtering by price

      if @price.present?
        @reviews = @reviews.where(price: @price)
      end

      #filter by cuisine
      if @cuisine.present?
        @reviews = @reviews.where(cuisine: @cuisine)
      end

      #search near the location
      if @location.present?
        @reviews = @reviews.near(@location)
      end

    end

    def new
      #form for adding a new review
      @review = Review.new
    end

    def create
      #take the info from the form and add to the model
      @review = Review.new(form_params)

      #then associate it to the user
      @review.user = @current_user

      #we want to check if the model can be saved
      #if it is we're going to the homepage again
      #if it isn't show the new form

      if @review.save
        redirect_to root_path
      else
        #show the view for new.html.erb
        render "new"
      end
    end

    def show
      #individual review page
      @review = Review.find(params[:id])
    end

    def destroy
      #find the individual review
      @review = Review.find(params[:id])
      #destroy it

      if @review.user == @current_user
        @review.destroy
      end
      #redirect to the homepage
      redirect_to root_path
    end

    def edit
      #find the individual review to edit
      @review = Review.find(params[:id])

      if @review.user != @current_user
        redirect_to root_path
      end
    end


    def update
      #find individual review
      @review = Review.find(params[:id])

      if @review_user != @current_user
        redirect_to root_path

      else
        #update with new info from form
        if @review.update(form_params)
          #redirect somewhere new
          redirect_to review_path(@review)
        else
          render "edit"
        end
      end
    end

    def form_params
      params.require(:review).permit(:title, :restaurant, :address, :body, :score, :ambiance, :cuisine, :price)
    end

end
