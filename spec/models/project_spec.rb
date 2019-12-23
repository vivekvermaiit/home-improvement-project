require 'rails_helper'

RSpec.describe Project, type: :model do

  before(:all) do
    @project = create(:project)
  end

  after(:all) do
    @project.destroy
  end

  it "is not valid without a name" do
    project2 = build(:project, name: nil)
    expect(project2).to_not be_valid
  end

  it "is not valid with name less than 4 characters" do
    project2 = build(:project, name: "tes")
    expect(project2).to_not be_valid
  end

  it "is not valid with name more than 50 chanracters" do
    project2 = build(:project, name: "a"*51)
    expect(project2).to_not be_valid
  end

  it "is not valid without a project_type" do
    project2 = build(:project, project_type: nil)
    expect(project2).to_not be_valid
  end

  it "is not valid for random project type" do
    project2 = build(:project, project_type: "random")
    expect(project2).to_not be_valid
  end

end
