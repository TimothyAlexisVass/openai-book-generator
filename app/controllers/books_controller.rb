class BooksController < ApplicationController
  def new
    @categories = Category.pluck(:classification, :id, :name).group_by(&:first).transform_values { |values| values.map { |(_, id, name)| [id, name] } }.to_json
    @subcategories = Category.all.map{ |category| [category.id, category.subcategories.pluck(:id, :name)] }.to_h.to_json
    @book = Book.new
  end

  def index
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
    @chapters = @book.chapters.order(:number)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "Book successfully removed."
  end

  private

  def book_params
    params.permit(:classification, :category_id, :subcategory_id, :title)
  end
end
