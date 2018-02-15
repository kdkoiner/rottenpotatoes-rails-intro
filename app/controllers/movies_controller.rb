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
    @movie1 = Movie.find(1)
    @movie2 = Movie.find(2)
    @movies[1], @movies[2] = @movie2, @movie1
    
    redirect_to movies_path
  end


  def sort_title
  
    for i in 0..Movie.length - 1
      j = i + 1
      for j in j..Movie.length - 1
        element1 = Movie.find(i)
        element2 = Movie.find(j)
        if (element1.title < element2.title)
          @movie1 = Movie.find(i)
		  @movie2 = Movie.find(j)
		  
		  @movie1.id = element2.id
		  @movie2.id = element1.id
		  
        end
      end
    end
    
    redirect_to movies_path
    
  end
   
  def sort_date
  
    for i in 0..Movie.length - 1
      j = i + 1
      for j in j..Movie.length - 1
        element1 = Movie.find(i)
        element2 = Movie.find(j)
        if (element1.release_date < element2.release_date)
          Movie[i] = element2
          Movie[j] = element1
        end
      end
    end
    
    redirect_to movies_path
    
  end
  
  def sort_id
  
    for i in 0..Movie.length - 1
      j = i + 1
      for j in j..Movie.length - 1
        element1 = Movie.find(i)
        element2 = Movie.find(j)
        if (element1.release_date < element2.release_date)
          Movie[i].id, Movie[j].id = Movie[j].id, Movie[i].id
        end
      end
    end
    
    redirect_to movies_path
    
  end


end
