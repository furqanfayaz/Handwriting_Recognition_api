class Api::HandwritingRecognitionController < ApplicationController
  before_action :set_service

  def index
    response = @service.get_all(params)
    render json: response
  end

  def upload
    response = @service.upload(params)
    render json: response
  end

  private

  def set_service
    @service ||= ::HandwritingRecognitionService
  end
end