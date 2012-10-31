class Api::V1::DisciplinesController < Api::V1::BaseController
  def index
    respond_with(Discipline.all)
  end
end