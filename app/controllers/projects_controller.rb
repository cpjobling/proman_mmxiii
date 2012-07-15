class ProjectsController < ApplicationController
  def index
    @projects = Project.all.page(params[:page]).per(10)
  end

  def show
    @project = Project.find(params[:id])
    session[:last_projects_page] = request.env['HTTP_REFERER'] || projects_url
  end

  def by_discipline
  end
end
