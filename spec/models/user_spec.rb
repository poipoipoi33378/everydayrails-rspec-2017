require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  # it "is valid with a first name, last nema, email and password" do
  #   user = User.new(first_name: "Aaron",
  #                   last_name:  "Sumner",
  #                   email:      "tester@example.com",
  #                   password:   "dottle-nouveau-pavilion-tights-furze")
  #   expect(user).to be_valid
  # end
  #
  # it "is invalid without a first name" do
  #   user = FactoryBot.build(:user,first_name: nil)
  #   user.valid?
  #   expect(user.errors[:first_name]).to include("can't be blank")
  # end
  #
  # it "is invalid without a last name" do
  #   user = FactoryBot.build(:user,last_name: nil)
  #   user.valid?
  #   expect(user.errors[:last_name]).to include("can't be blank")
  # end
  #
  # it "is invalid without an email address" do
  #   user = FactoryBot.build(:user,email: nil)
  #   user.valid?
  #   expect(user.errors[:email]).to include("can't be blank")
  # end

  it "is invgitalid without a duplicate email address" do
    FactoryBot.create(:user, email: "tester@example.com")
    user = FactoryBot.build(:user, email: "tester@example.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user,first_name: "Aaron", last_name:  "Sumner")
    expect(user.name).to eq("Aaron Sumner")
  end

  it "does something with multiple users" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    expect(true).to be_truthy
  end

end
