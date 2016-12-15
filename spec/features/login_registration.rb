require "rails_helper"

describe "Register" do
  it "prompts for the user fields" do
    visit "/"
    expect(page).to have_field('user[name]')
    expect(page).to have_field('user[email]')
    expect(page).to have_field('user[description]')
    expect(page).to have_field('user[password]')
    expect(page).to have_field('user[password_confirmation]')
  end
  it "creates user and redirects to user's page" do

    visit "/"
    fill_in "user[name]", with: "Luke Skywalker"
    fill_in "user[email]", with: "sky@walker.com"
    fill_in "user[description]", with: "test description"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"

    click_button "Register"
    user = User.last
    expect(current_path).to eq("/events")
    expect(page).to have_text("Luke Skywalker")
  end
end

describe "Login" do

  user  = User.create(name:"Jonathan Coco", email:"cocojonathan@yahoo.com", description:"test", password:"password", password_confirmation:"password")

  it "prompts for the login fields" do
    visit "/"
    expect(page).to have_field('email')
    expect(page).to have_field('password')
  end
  it "logs in user and redirects to events page" do
    visit "/"
    fill_in "email", with: "cocojonathan@yahoo.com"
    fill_in "password", with: "password"
    click_button "Login"
    user = User.last
    expect(current_path).to eq("/events")
    expect(page).to have_text("Jonathan Coco")
  end
end
