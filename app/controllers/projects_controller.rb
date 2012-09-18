class ProjectsController < ApplicationController

  helper_method :sort_column, :sort_direction

  def index
    @projects = Project.search(params[:search]).order_by([sort_column,sort_direction]).page(params[:page]).per(20)
  end

  def show
    @project = Project.find(params[:id])
    session[:last_projects_page] = request.env['HTTP_REFERER'] || projects_url
  end

  def by_discipline
    @discipline = Discipline.first(conditions: { code: params[:discipline]})
    @projects = Project.search(params[:search]).where(discipline_id: @discipline._id)
        .unassigned
        .order_by([sort_column,sort_direction])
        .page(params[:page]).per(20)
        
  end

  def allocated
   @projects = Project.assigned
        .order_by([sort_column,sort_direction])
        .page(params[:page]).per(20)
  end

  def unavailable
    @projects = Project.unavailable.order_by([sort_column,sort_direction]).page(params[:page]).per(20)
  end
  
  private

    def sort_column
      Project.column_names.include?(params[:sort]) ? params[:sort] : "pid"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction].to_sym : :asc
    end

end
