require "rspec"

describe Name do

  let (:name) { Name.new('Prof.','John', 'Ronald Reuel', 'Tolkien') }

  it "prints name in full" do
    name.to_s.should eql "Prof. John Ronald Reuel Tolkien"
  end
end