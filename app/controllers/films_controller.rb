class FilmsController < ApplicationController
  before_action :set_film, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @films = policy_scope(Film)
  end

  def show
    authorize @film
  end

  def new
    @film = Film.new
  end

  def edit
    authorize @film
  end

  def create
    @film = Film.new(film_params)

    if @film.save
      redirect_to @film, notice: 'Film was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @film

    if @film.update(film_params)
      redirect_to @film, notice: 'Film was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @film
    @film.destroy

    redirect_to films_url, notice: 'Film was successfully destroyed.'
  end

  private

  def set_film
    @film = Film.find(params[:id])
  end

  def film_params
    params.require(:film).permit(:title, :poster, :year, :trailer, :director, :description, genres: [], online_cinemas: [])
  end
end
