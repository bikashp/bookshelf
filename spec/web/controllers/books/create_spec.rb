require 'spec_helper'
require_relative '../../../../apps/web/controllers/books/create'

describe Web::Controllers::Books::Create do
  let(:action) { Web::Controllers::Books::Create.new }

  before do
    BookRepository.clear
  end

  describe 'with valid params' do
    let(:params) { Hash[book: { title: 'Confident Ruby', author: 'Avdi Grimm'}] }

    it 'creates a new book' do
      action.call(params)

      action.book.id.wont_be_nil
      action.book.title.must_equal params[:book]['title']
    end

    it 'is successful' do
      response = action.call(params)
      response[0].must_equal 302
    end
  end

  describe 'with invalid params' do
    let(:params) { Hash[book: {}] }

    it 're-renders the books#new view' do
      response = action.call(params)

      response[0].must_equal 200
    end

    it 'sets errors attribute accordingly' do
      action.call(params)
      refute action.params.valid?

      action.errors.for('book.title').wont_be_empty
      action.errors.for('book.author').wont_be_empty
    end
  end
end
