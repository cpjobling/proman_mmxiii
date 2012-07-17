class ProjectsController < ApplicationController
  def index
    @projects = Project.all.page(params[:page]).per(20)
  end

  def show
    @project = Project.find(params[:id])
    session[:last_projects_page] = request.env['HTTP_REFERER'] || projects_url
  end

  def by_discipline
    @discipline = Discipline.first(conditions: { code: params[:discipline]})
    @projects = @discipline.projects.all.page(params[:page]).per(20)
  end
end
