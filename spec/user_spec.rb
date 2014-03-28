require 'spec_helper'

describe User do
  it "is valid with an email" do
    user = User.new(
      email: 'harry@ga.co'
    )
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = User.new
    expect(user).to be_invalid
  end

  it "is a valid email" do
    user = User.new(
        email: "sadfa@sdafkj.com"
      )
    expect(user.email).to match /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/
  end

  it "is an invalid email" do
    user = User.new(
        email: "s*^()(&^"
      )
    expect(user.email).not_to match /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/
  end

  it "is invalid without a salt" do
    user = User.new
    expect(user).to be_invalid
  end

  it "is invalid without a fish" do
    user = User.new
    expect(user).to be_invalid
  end

end