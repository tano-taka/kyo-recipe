module LikeDoneSupport
  def like_done(recipe)
    visit recipe_path(recipe)
    expect(page).to have_content 'いい値'
    click_on 'いい値'
    expect(page).to have_selector '.content-like-done', text: 'いい値!(済)'
    visit root_path
    expect(page).to have_content 'いい値'
  end
end
