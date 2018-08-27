require 'rails_helper'

RSpec.describe Note, type: :model do

  context "file attached test for Shoulda version" do
    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project, owner: user) }
    it { is_expected.to have_attached_file(:attachment) }
  end

  describe "factory test" do
    it "generates associated data from a factory" do
      note = FactoryBot.create(:note)
      puts "This note's project is #{note.project.inspect}"
      puts "This note's user is #{note.user.inspect}"
    end
  end

  describe "check validation" do

    let(:user){ FactoryBot.create(:user) }
    let(:project){ FactoryBot.create(:project) }

    it "is valid with a user, project, and message" do
      note = project.notes.create(
          message: "This is the first note",
          user: user,
          project: project,
          )
      expect(note).to be_valid
    end

    it "is invalid without a message" do
      note = Note.new(message:nil)
      note.valid?
      expect(note.errors[:message]).to include("can't be blank")
    end

    describe "search message for a term" do

      let!(:note1) do
        FactoryBot.create(:note,project: project,message: "This is the first note",user: user)
      end

      let!(:note2) do
        FactoryBot.create(:note,project: project,message: "This is the second note",user: user)
      end

      let!(:note3) do
        FactoryBot.create(:note,project: project,message: "First,preheat the oven",user: user)
      end

      context "when a match is found" do
        it "returns notes that match the search term" do
          expect(Note.search("first")).to include(note1,note3)
          expect(Note.search("first")).to_not include(note2)
        end
      end
      context "when no match is found" do
        it "returns an empty collection when no results are found" do
          expect(Note.search("message")).to be_empty
          expect(Note.count).to eq 3
        end
      end
    end
  end

  it "delegates name to the user who created it" do

    user = instance_double("User",name: "Fake User")
    note = Note.new
    allow(note).to receive(:user).and_return(user)
    expect(note.user_name).to eq "Fake User"
  end
end
