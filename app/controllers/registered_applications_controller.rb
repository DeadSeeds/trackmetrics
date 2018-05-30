class RegisteredApplicationsController < ApplicationController

  def index
    @apps = RegisteredApplication.where(user_id: current_user.id)
    @user = current_user
  end

  def show
    @app = RegisteredApplication.find(params[:id])
  end

  def new
    @app = RegisteredApplication.new
    @user = current_user
  end

  def create
    @app = RegisteredApplication.new(app_params)
    @app.user = current_user
    @apps = RegisteredApplication.all

    if @app.save
      flash[:notice] = "Application was saved."
      redirect_to registered_applications_path
    else
      flash.now[:alert] = "There was an error saving the application."
    end
  end

  def edit
    @app = RegisteredApplication.find(params[:id])
    @app.user = current_user
  end

  def update
    @app = RegisteredApplication.find(params[:id])
    @app.assign_attributes(app_params)

    if @app.save
      flash[:notice] = "Application was saved."
      redirect_to registered_applications_path
    else
      # flash.now[:alert] = "There was an error saving the application."
      render :edit
    end
  end


  def destroy
    @app = RegisteredApplication.find(params[:id])

    if @app.destroy
      flash[:notice] = "App was deleted."
      redirect_to registered_applications_path
    else
      flash.now[:alert] = "There was an error removing the application."
    end
  end

  private

  def app_params
    @user_id = current_user.id
    params.require(:registered_application).permit(:name, :url)
  end

end
