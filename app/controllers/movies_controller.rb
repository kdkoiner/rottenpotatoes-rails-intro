class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
   
    @movies = Movie.all
    
    if(!params.has_key?(:ratings) && !params.has_key?(:sort))
      if(session.has_key?(:ratings) || session.has_key?(:sort))
        redirect_to movies_path(:ratings=>session[:ratings], :sort=>session[:sort])
      end
    end
    
    
    
    @all_ratings = ['G', 'PG', 'PG-13', 'R']
    @selected_ratings = params[:ratings]
    
    if @selected_ratings == nil
      @selected_ratings = @all_ratings
      selected_ratings_keys = @all_ratings
      selected_ratings_keys = session[:ratings].keys
    else
      selected_ratings_keys = @selected_ratings.keys
      session[:ratings] = @selected_ratings
    end
    
    @movies = Movie.where(:rating => selected_ratings_keys)
    
    
    
    @sort = params.has_key?(:sort) ? (session[:sort] = params[:sort]) : session[:sort]
    
    if @sort == 'title'
      @movies = @movies.sort_by{ |m| m.title }
    end
    
    if @sort == 'release_date'
      @movies = @movies.sort_by{ |m| m.release_date }
    end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def sort_test
    @movies = Movie.all
    @movies = @movies.sort_by{ |m| m.title }
    redirect_to movies_path
  end


  def sort_title
  
    @movies = Movie.all
    @movies = @movies.sort_by{ |m| m.title }
    
    redirect_to movies_path
    
  end
   
  def sort_date
  
    @movies = Movie.all
    @movies = @movies.sort_by{ |m| m.release_date }
    
    redirect_to movies_path
    
  end

end
