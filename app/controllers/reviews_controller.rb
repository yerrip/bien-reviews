class ReviewsController < ApplicationController


  def index
    #this is our list page for reviews


  @number = rand(100)

  @reviews = Review.all

  end

  def new
    #form for adding a new review
    @review = Review.new
  end

  def create
    #take the info from the form and add to the model
    @review = Review.new(form_params)

    #we want to check if the model can be saved
    #if it iswe're going to the homepage again
    #if it isn't show the new form

    if @review.save
      redirect_to root_path
    end

  else
    #show the view for new.html.erb
    render "new"

  end

  def show

    #individual review page
    @review = Review.find(params[:id])

  end

  def destroy
    #find the individual review
    @review = Review.find(params[:id])
    #destroy it
    @review.destroy
    #redirect to the homepage
    redirect_to root_path

  end

  def edit
    #find the individual review to edit
    @review = Review.find(params[:id])

  end


  def update
    #find individual review
    @review = Review.find(params[:id])
    #update with new info from form
    if @review.update(form_params)
      #redirect somewhere new
      redirect_to review_path(@review)
    else
      render "edit"
    end
  end

  def form_params
    params.require(:review).permit(:title, :body, :score)
  end

end
