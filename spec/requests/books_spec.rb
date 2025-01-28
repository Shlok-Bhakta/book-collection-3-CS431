require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/books', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Book. As you add validations to Book, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      title: 'The Great Gatsby', # Valid because title is present
      author: 'F. Scott Fitzgerald', # Valid because author is present
      price: 10.0, # Valid because price is present
      published_date: Date.new(2022, 1, 1) # Valid because published_date is present
    }
  end

  let(:invalid_attributes) do
    {
      title: nil, # Invalid because title is not present
      author: nil, # Invalid because author is not present
      price: nil, # Invalid because price is not present
      published_date: nil # Invalid because published_date is not present
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Book.create! valid_attributes
      get books_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      book = Book.create! valid_attributes
      get book_url(book)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_book_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      book = Book.create! valid_attributes
      get edit_book_url(book)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Book' do
        expect do
          post books_url, params: { book: valid_attributes }
        end.to change(Book, :count).by(1)
      end

      it 'redirects to the created book' do
        post books_url, params: { book: valid_attributes }
        expect(response).to redirect_to(book_url(Book.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Book' do
        expect do
          post books_url, params: { book: invalid_attributes }
        end.to change(Book, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post books_url, params: { book: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          title: 'A New Title Wahoo', # Valid because title is present (but not updated)
          author: 'Another Author 2', # Valid because author is present (but not updated)
          price: 100.0, # Valid bec    ause price is present (but not updated)
          published_date: '2024-01-01' # Valid because published_date is present (but not updated)
        }
      end

      it 'updates the requested book' do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: new_attributes }
        book.reload
        expect(book.title).to eq('A New Title Wahoo')
        expect(book.author).to eq('Another Author 2')
        expect(book.price).to eq(100.0)
        expect(book.published_date).to eq(Date.new(2024, 1, 1))
      end

      it 'redirects to the book' do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: new_attributes }
        book.reload
        expect(response).to redirect_to(book_url(book))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested book' do
      book = Book.create! valid_attributes
      expect do
        delete book_url(book)
      end.to change(Book, :count).by(-1)
    end

    it 'redirects to the books list' do
      book = Book.create! valid_attributes
      delete book_url(book)
      expect(response).to redirect_to(books_url)
    end
  end
end
