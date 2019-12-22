class HandwritingRecognitionService
  require 'google/cloud/vision'
  require "google/cloud/storage"

  def self.get_all(params)
    image_details = ImageDetail.all
    image_details = image_details.order("created_at desc")
    count = image_details.count
    return {
      success: true,
      total: count,
      image_details: image_details.as_json(ImageDetail.as_json_query)
    }
  end

  def self.upload(params)
    file = params[:file]
    raise "file not provided" if file.blank?
    bucket_name = Figaro.env.BUCKET_NAME
    storage = Google::Cloud::Storage.new
    bucket = storage.bucket bucket_name
    url = upload_image(bucket,file)
    text = _get_text_from_vision_api(file)
    raise "no data from vision api" if text.blank?
    create_params = {
      url: url,
      text: text
    }
    image = ImageDetail.create!(create_params)
    return {
      success: true,
      data: image.as_json(ImageDetail.as_json_query)
    }
  end

  def self.upload_image(bucket,file)
    begin
      file = bucket.create_file( file.tempfile, content_type: file.content_type, acl: "public")
      file.public_url
    rescue => err
      raise err
    end
  end

  def self._get_text_from_vision_api(file)
    begin
      vision = Google::Cloud::Vision.new
      image = vision.image file.tempfile
      response = image.text
      image_text = response.text.gsub("\n"," ")
    rescue => err
      raise err
    end
  end
end