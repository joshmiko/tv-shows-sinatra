require "spec_helper"

feature "user adds a new TV show" do
  # As a TV fanatic
  # I want to add one of my favorite shows
  # So that I can encourage others to binge watch it
  #
  # Acceptance Criteria:
  # * I must provide the title, network, and starting year.
  # * I can optionally provide the final year, genre, and synopsis.
  # * The synopsis can be no longer than 5000 characters.
  # * The starting year and ending year (if provided) must be
  #   greater than 1900.
  # * The genre must be one of the following: Action, Mystery,
  #   Drama, Comedy, Fantasy
  # * If any of the above validations fail, the form should be
  #   re-displayed with the failing validation message.

  scenario "successfully add a new show" do

    game_of_thrones = TelevisionShow.create!({
        title: "Game of Thrones", network: "HBO",
        starting_year: 2011, genre: "Fantasy"
      })

    visit "/television_shows"

    expect(page).to have_content("Game of Thrones (HBO)")
end
  scenario "fail to add a show with invalid information" do

    visit "/television_shows/new"

    fill_in('television_show[network]', with: 'Fox')
    fill_in('television_show[starting_year]', with: '1899')
    select('Comedy', from: 'television_show[genre]')
    click_button('Add TV Show')

    expect(page).to have_content("error")

  end
end
