class RegisteredApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @apps = current_user.registered_applications
    authorize @apps
  end

  def show
    @app = RegisteredApplication.find(params[:id])
    authorize @app
    @events = @app.events.group_by(&:name)
  end

  def new
    @app = RegisteredApplication.new
    @user = current_user
  end

  def create
    @app = RegisteredApplication.new(app_params)
    @app.user = current_user
    authorize @app

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
    authorize @app
  end

  def update
    @app = RegisteredApplication.find(params[:id])
    @app.assign_attributes(app_params)
    authorize @app

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
    params.require(:registered_application).permit(:name, :url)
  end

end
