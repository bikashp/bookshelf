require 'features_helper'

describe 'Books' do
  after do
    BookRepository.clear
  end

  it 'can create a new book' do
    visit '/books/new'

    within 'form#book-form' do
      fill_in 'Title', with: 'New book'
      fill_in 'Author', with: 'Some Author'

      click_button 'Create'
    end

    current_path.must_equal('/books')
    assert page.has_content?('New book')
  end

  it 'displays list of errors when params contain errors' do
    visit '/books/new'

    within 'form#book-form' do
      click_button 'Create'
    end

    current_path.must_equal('/books')

    assert page.has_content?('There was a problem with your submission.')
    assert page.has_content?('Title is required.')
    assert page.has_content?('Author is required.')


  end
end