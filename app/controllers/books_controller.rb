class BooksController < ApplicationController
  include GptRequestable

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

  def draft
    @book = Book.find(params[:id])
    
    @chapter_titles = @book.chapters.map{|e| e.title}.join(", ")

    @book.chapters.each do |chapter|
      section_titles = chapter.sections.map{|e| e.title}.join(", ")
      chapter.sections.each do |section|
        system_message = 'Do not put the chapter or section name in the array. Do not number the paragraphs. I want only the actual paragraph text in the array. Do not escape the quotation marks around the strings inside the array. The array should only contain one string for each paragraph text, nothing outside the array. Write actual text that will be in the book.'
        user_message = "We are writing a book titled #{@book.title}. It contains the chapters #{@chapter_titles}. The current chapter is #{chapter.title}, which has the sections #{section_titles}. Your task is to generate all the paragraphs of text for the section #{section.title}. I only need the text in paragraphs in one array. I need to be able to parse the array using JSON.parse, so respond with only one array with a string for each paragraph in this format: [\"paragraphtext\", \"paragraphtext\", etc]. Don't escape the quotation marks for the strings like this: [\\\"paragraphtext\\\"] or in any other way. Don't return the section name like this: [\"<section name>\"]\"paragraph\", \"paragraph\"."

        paragraphs = send_gpt_request(system_message, user_message)
        paragraphs.each_with_index do |paragraph_text, index|
          Paragraph.create(section_id: section.id, text: paragraph_text, number: index)
          puts "Paragraph #{index} for Chapter #{chapter.title}, section #{section.title} created"
        end
      end
    end
    
    redirect_to books_path, notice: "Draft written." 
  end

  private

  def book_params
    params.permit(:classification, :category_id, :subcategory_id, :title)
  end
end
