class ChaptersController < ApplicationController
  before_action :set_book

  def index
    @chapters = @book.chapters.order(:number)
  end

  def handle
    chapters_params = params[:chapters]
  
    params_chapter_ids = chapters_params.select{|chapter| chapter[:id].present?}.pluck(:id)
    existing_chapter_ids = @book.chapters.pluck(:id)
    @book.chapters.where.not(id: params_chapter_ids).destroy_all

    chapter_number = @book.chapters.size

    chapters_params.each do |chapter|
      if chapter[:id].present? && existing_chapter_ids.include?(chapter[:id].to_i)
        # Update existing chapter
        @book.chapters.find(chapter[:id]).update(title: chapter[:title], number: chapter[:number])
      elsif chapter[:title].present?
        chapter_number += 1
        @book.chapters.create(title: chapter[:title], number: chapter_number)
      end
    end
  
    redirect_to book_chapters_path(@book), notice: 'Chapters processed successfully.'
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
