class CorrectionsController < ApplicationController
  before_action :set_post
  before_action :set_correction, only: [:show, :destroy]

  def new
    @correction = @post.corrections.new
  end

  def create
    @correction = @post.corrections.new(user: current_user)

    if @correction.save
      Rails.logger.debug "Corrections param: #{params[:corrections].inspect}"
      
      if params[:corrections].present?
        process_corrections(params[:corrections])
        redirect_to post_correction_path(@post, @correction), notice: 'Correction was successfully created.'
      else
        @correction.destroy
        flash.now[:alert] = 'No corrections were provided.'
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @correction.destroy
    redirect_to post_path(@post), notice: 'Correction was successfully deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_correction
    @correction = @post.corrections.includes(post: :post_sentences, correction_sentences: :post_sentence).find(params[:id])
  end

  def process_corrections(corrections_data)
    Rails.logger.debug "Starting process_corrections with data: #{corrections_data.inspect}"

    return unless corrections_data.is_a?(Array)

    corrections_data.each do |correction_data|
      Rails.logger.debug "Processing correction: #{correction_data.inspect}"

      if correction_data[:correction].blank?
        Rails.logger.debug "Skipping correction due to blank correction"
        next
      end

      post_sentence = @post.post_sentences.find_by(text: correction_data[:text])
      
      if post_sentence.nil?
        Rails.logger.debug "Skipping correction due to missing post sentence"
        next
      end

      Rails.logger.debug "Creating correction sentence for post sentence ID: #{post_sentence.id}"
      
      correction_sentence = @correction.correction_sentences.create(
        post_sentence: post_sentence,
        corrected_text: correction_data[:correction],
        explanation: correction_data[:explanation]
      )

      Rails.logger.debug "Correction sentence created: #{correction_sentence.inspect}"
    end

    Rails.logger.debug "Finished process_corrections"
  end
end
