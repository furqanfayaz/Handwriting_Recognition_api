class HandwritingRecognitionService

  def self.index(params)
    image_details = ImageDetail.all
    image_details = image_details.order("created_by desc")
    return {
      success: true,
      image_details: image_details.as_json(ImageDetail.as_json_query)
    }
  end

  def self.upload(params)
    url = params[:url] if params[:url].present? params[:url] : nil
    raise "url not provided" if url.blank?
    text = _get_text_from_vision_api(url)
    raise "no data from vision api" if text.blank? 
    create_params = {
      url: url,
      text: text
    }
    image = ImageDetail.create!(create_params)
    return {
      success: true,
      image: image.as_json(ImageDetail.as_json_query)
    }
  end

  def self._get_text_from_vision_api(url)
    begin
      vision = Google::Cloud::Vision.new
      image = vision.image url
      response = image.text
      image_text = response.text.gsub("\n"," ")
    rescue => err
      raise err
    end
  end
end