class Api::V1::BooksController < Api::V1::BaseController
  def index
    @books = current_user.books
    @books = @books.where category: params[:category] if params[:category]
    @books = @books.where status: params[:status] if params[:status]
    render json: convert(@books)
  end

  def show
    @book = current_user.books.find params[:id]
    render json: convert(@book)
  end

  def create
    @book = current_user.books.new book_params
    @book.status = Book.statuses.keys.first if params[:status].blank?
    @book.category = Book.categories.keys.first if params[:category].blank?

    begin
      @book.save
      render json: convert(@book)
    rescue ArgumentError
      render json: { errors: [ "Invalid category or status." ] }, status: :bad_request
    end
  end

  def update
    @book = current_user.books.find params[:id]

    begin
      @book.update book_params
      render json: convert(@book)
    rescue ArgumentError
      render json: { errors: [ "Invalid category or status." ] }, status: :bad_request
    end
  end

  def destroy
    current_user.books.find(params[:id]).destroy
    head :no_content
  end

  private

  def book_params
    # render json: { errors: [ "Status and category must not be nil." ] } if params[:status].blank? || params[:category].blank?
    params.permit :status, :picture_url, :title, :all_chapters, :read_chapters, :category, :author
  end

  def convert(book)
    {
      title: book.title,
      category: book.category,
      status: book.status,
      author: book.author,
      picture_url: book.picture_url,
      all_chapters: book.all_chapters,
      read_chapters: book.read_chapters
    }
  end
end
