require 'spec_helper'

describe "/api/v1/disciplines", type: :api do
  let!(:user)       { FactoryGirl.create(:user) }
  let!(:token)      { user.authentication_token }
  let!(:discipline) { FactoryGirl.create(:discipline) }

  before do
    # user.permissions.create!(action: "view", :thing => discipline)
  end

  context "disciplines viewable by this user" do
    let (:url) { "/api/v1/disciplines" }

    it "should return json" do
      get "#{url}.json", token: token

      disciplines_json = Discipline.all.to_json

      last_response.body.should eql(disciplines_json)
      last_response.status.should eql(200)

      disciplines = JSON.parse(last_response.body)

      disciplines.any? do |d|
        d["name"] == discipline.name
        d["code"] == discipline.code
      end.should be_true
    end
  end
end
