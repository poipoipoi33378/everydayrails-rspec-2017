require 'rails_helper'

RSpec.feature "Notes", type: :feature do

  context "Normal version" do
    let(:user) { FactoryBot.create(:user) }
    let(:project) do
      FactoryBot.create(:project,
                        name: "RSpec tutorial",
                        owner: user)
    end


    scenario "user uploads an attachment" do
      login_as user, scope: :user
      visit project_path(project)
      click_link "Add Note"
      fill_in "Message",with: "My book cover"
      attach_file "Attachment","#{Rails.root}/spec/files/attachment.png"
      click_button "Create Note"
      expect(page).to have_content "Note was successfully created"
      expect(page).to have_content "My book cover"
      expect(page).to have_content "attachment.png (image/png"
    end
  end
end
