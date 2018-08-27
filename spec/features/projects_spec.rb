require 'rails_helper'

RSpec.feature "Projects", type: :feature do


  scenario "user creates a new project" do
    user = FactoryBot.create(:user)
    sign_in user, scope: :user
    visit root_path

    expect do
      click_link "New Project"
      fill_in "Name", with: "Test Project"
      fill_in "Description", with: "Trying out Capybara"
      click_button "Create Project"
    end.to change(user.projects, :count).by(1)

    aggregate_failures do
      expect(page).to have_content "Project was successfully created"
      expect(page).to have_content "Test Project"
      expect(page).to have_content "Owner: #{user.name}"

    end
  end

  scenario "guest adds a project" do
    user = FactoryBot.create(:user)
    sign_in user,scope: :user

    visit projects_path
    #save_and_open_page
    click_link "New Project"
  end

  scenario "user completes a project"  do
    #プロジェクトを持ったユーザーを準備する
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project,owner: user)

    # ユーザーはログインしている
    login_as user, scope: :user

    # ユーザーがプロジェクト画面を開き
    visit project_path(project)

    # "complete"ボタンをクリックすると
    expect(page).to_not have_content "Completed"
    click_button "Complete"

    #save_and_open_page

    # プロジェクトは完了済みとしてマークされる
    expect(project.reload.completed?).to be true
    expect(page).to have_content "Congratulations, this project is complete!"
    expect(page).to have_content "Completed"
    expect(page).to_not have_button "Complete"
  end

end
