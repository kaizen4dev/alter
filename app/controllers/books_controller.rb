class BooksController < ApplicationController
  def index
    @category = params[:category] || Book.categories.keys.first
    @status = params[:status] || Book.statuses.keys.first
    @books = current_user.books.where category: @category, status: @status
  end

  def show
    @book = current_user.books.find_by id: params[:id]
  end

  def new
    @book = current_user.books.new category: params[:category], status: params[:status]
  end

  def edit
    @book = current_user.books.find_by id: params[:id]
  end

  def create
    @book = current_user.books.create book_params
    redirect_to books_path(category: @book.category, status: @book.status)
  end

  def update
    @book = current_user.books.find_by id: params[:id]
    @book.update book_params
    redirect_to books_path(category: @book.category, status: @book.status)
  end

  def destroy
    book = current_user.books.find_by id: params[:id]
    book.destroy
    redirect_to books_path(category: book.category)
  end

  def change_chapters
    book = current_user.books.find_by id: params[:id]
    book.update read_chapters: (book.read_chapters || 0) + params[:number].to_i
    redirect_back(fallback_location: book_path(id: params[:id]))
  end

  private

  def book_params
    p = params.expect book: [ :status, :picture_url, :title, :all_chapters, :read_chapters, :category, :author ]
  end
end
