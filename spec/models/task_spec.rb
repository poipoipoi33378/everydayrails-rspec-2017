require 'rails_helper'

RSpec.describe Task, type: :model do

  let(:project){ FactoryBot.create(:project) }

  it "it valid vith project and name" do
    task = Task.new(project: project,name: "Test task")
    expect(task).to be_valid
  end

  it "is invalid without a name" do
    task = Task.new(name: nil)
    task.valid?
    expect(task.errors[:name]).to include("can't be blank")
  end
end
