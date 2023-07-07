class SectionsController < ApplicationController
  before_action :set_book

  def index
    @chapters = @book.chapters.order(:number)
  end

  def handle
    sections_params = params[:sections]
    @book.chapters.each do |chapter|
      chapter_sections_params = sections_params.select { |section| section[:chapter_id].to_i == chapter.id }

      section_ids = chapter.sections.pluck(:id)
      params_section_ids = chapter_sections_params.select { |section| section[:id].present? }.pluck(:id)

      chapter.sections.where.not(id: params_section_ids).destroy_all

      section_number = chapter.sections.size

      chapter_sections_params.each do |section|
        if section[:id].present? && section_ids.include?(section[:id].to_i)
          # Update existing section
          chapter.sections.find(section[:id]).update(title: section[:title], number: section[:number])
        elsif section[:title].present?
          section_number += 1
          chapter.sections.create(title: section[:title], number: section_number)
        end
      end
    end

    redirect_to book_sections_path(@book), notice: 'Sections processed successfully.'
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
