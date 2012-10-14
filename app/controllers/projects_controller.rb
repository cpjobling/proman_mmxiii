class ProjectsController < ApplicationController

  helper_method :sort_column, :sort_direction

  before_filter :find_project, :only => [:show]

  def index
    respond_to do |format|
      format.html do 
        @projects = Project.search(params[:search]).order_by([sort_column,sort_direction]).page(params[:page]).per(20)
        render 'projects/index'
      end
      format.csv do
        @projects = Project.asc(:pid)
        send_data @projects.to_csv
      end
    end
  end

  def show
    session[:last_projects_page] = request.env['HTTP_REFERER'] || projects_url
  end

  def by_discipline
    @discipline = Discipline.first(conditions: { code: params[:discipline]})
    respond_to do |format|
      format.html do
        @projects = Project.search(params[:search]).where(discipline_id: @discipline._id)
            .unassigned
            .order_by([sort_column,sort_direction])
            .page(params[:page]).per(20)
      end
      format.json do
        @projects = Project.where(discipline_id: @discipline._id).unassigned
        #render json: @projects
      end
    end
  end

  def allocated
   respond_to do |format|
      format.html do
        @projects = Project.assigned
            .order_by([sort_column,sort_direction])
            .page(params[:page]).per(20)
      end
      format.csv { send_data Project.assigned_to_csv }
    end
  end

  def unavailable
    @projects = Project.unavailable.order_by([sort_column,sort_direction]).page(params[:page]).per(20)
  end

  def tutors
    respond_to do |format|
      format.csv { send_data Project.tutor_list_as_csv }
    end
  end
  
  private

    def sort_column
      Project.column_names.include?(params[:sort]) ? params[:sort] : "pid"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction].to_sym : :asc
    end

    def find_project
      @project = Project.find(params[:id])
    rescue Mongoid::Errors::DocumentNotFound
      flash[:alert] = "The project you were looking for could not be found."
      redirect_to projects_path
    end

end
