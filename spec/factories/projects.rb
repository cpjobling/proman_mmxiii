FactoryGirl.define do
  sequence (:project_title) { |n| "Test Project #{n}" }
  factory :project do
    # Want to avoid creating associated records because they'll
    # throw validation errors
    discipline
    supervisor
    title { generate(:project_title) }
    description { Forgery(:lorem_ipsum).words(50) }
    available true
  end
end
