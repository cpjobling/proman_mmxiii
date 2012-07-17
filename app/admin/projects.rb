ActiveAdmin.register Project do
  form do |f|
    f.inputs "Details" do
      f.input :discipline # don't forget this one!
      f.input :supervisor
      f.input :title
      f.input :description, as: :text
    end
    f.inputs "Further information" do
      f.input :cross_disciplinary_theme
      f.input :associated_with
      f.input :available, as: :boolean
      f.input :students_own_project, as: :boolean
      f.input :student_number
      f.input :student_name
      f.input :allocated
      f.input :special_requirements, as: :text
    end
    f.buttons
  end
  
end
