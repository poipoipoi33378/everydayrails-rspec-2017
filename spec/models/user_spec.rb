require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a first name, last nema, email and password" do
    user = User.new(first_name: "Aaron",
                    last_name:  "Sumner",
                    email:      "tester@example.com",
                    password:   "dottle-nouveau-pavilion-tights-furze")
    expect(user).to be_valid
  end

  it "is invalid without a first name" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invgitalid without a duplicate email address" do
    User.create(first_name: "Jane",
                    last_name:  "Tester",
                    email:      "tester@example.com",
                    password:   "dottle-nouveau-pavilion-tights-furze")

    user = User.new(first_name: "Jane",
                    last_name:  "Tester",
                    email:      "tester@example.com",
                    password:   "dottle-nouveau-pavilion-tights-furze")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "returns a user's full name as a string" do
    user = User.new(first_name: "Aaron",
                    last_name:  "Sumner",
                    email:      "tester@example.com",
                    password:   "dottle-nouveau-pavilion-tights-furze")
    expect(user.name).to eq("Aaron Sumner")
  end

  describe "serch message for a term" do

  end
end
