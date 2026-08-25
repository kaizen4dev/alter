class FilmsController < ApplicationController
  def index
    @category = params[:category] || Film.categories.keys.first
    @status = params[:status] || Film.statuses.keys.first
    @counts = current_user.films.where(category: @category).group(:status).count
    @films = current_user.films.where category: @category, status: @status
  end

  def show
    @film = current_user.films.find_by id: params[:id]
  end

  def new
    @film = current_user.films.new category: params[:category], status: params[:status]
  end

  def edit
    @film = current_user.films.find_by id: params[:id]
  end

  def create
    @film = current_user.films.create film_params
    redirect_to films_path(category: @film.category, status: @film.status)
  end

  def update
    @film = current_user.films.find_by id: params[:id]
    @film.update film_params
    redirect_to films_path(category: @film.category, status: @film.status)
  end

  def destroy
    film = current_user.films.find_by id: params[:id]
    film.destroy
    redirect_to films_path(category: film.category)
  end

  private

  def film_params
    p = params.expect film: [ :status, :picture, :title, :all_episodes, :seen_episodes, :category ]
  end
end
