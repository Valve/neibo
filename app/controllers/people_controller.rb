class PeopleController < ApplicationController
  def index
    if current_user
      if params[:search].present? || params[:radius].present?
        search = Person.search do 
          without(:id, current_user.id)
          fulltext params[:search]
          if current_user.has_location? 
            with(:location).in_radius(current_user.lat, current_user.lon, params[:radius])
          end
          without(:dislikes, params[:search]) if params[:search].present?
        end
        @people = search.results
      else
        @people = []
      end
    else
      @new_person = Person.new
    end
  end

  def create
    @new_person = Person.new(person_params)
    if @new_person.save
      session[:current_user_id] = @new_person.id
      redirect_to people_path
    else
      flash.now.alert = 'Please fill your profile'
      render :index
    end
  end

  private

  def person_params
    params.require(:person).permit(:name, :about, :likes, :dislikes, :lat, :lon)
  end
end
