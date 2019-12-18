class Api::HandwritingRecognitionController < ApplicationController
  before_action :set_service

  def index
    response = @service.get_all(params)
    render json: response
  end

  def upload
    response = @service.upload(upload_params)
    render json: response
  end

  private

  def set_service
    @service ||= ::HandwritingRecognitionService
  end

  def upload_params
    params.permit(:url)
  end

  def params
    params.permit(:id)
  end
end