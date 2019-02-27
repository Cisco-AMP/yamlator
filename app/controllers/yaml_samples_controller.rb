require 'zip'

class YamlSamplesController < ApplicationController
  def create
    if yaml_sample_params[:text]
      create_from_text
    elsif yaml_sample_params[:file]
      file_type = yaml_sample_params[:file].content_type
      logger.info file_type
      if file_type == "application/zip"
        create_from_zip_file
      elsif
        create_from_yaml_file
      end
    end
  end

  def create_from_text
    @yaml_sample = YamlSample.new(yaml_sample_params[:text])
    render @yaml_sample
  end

  def create_from_yaml_file
    yaml_text = yaml_sample_params[:file].read
    @yaml_sample = YamlSample.new(yaml_text)
    render @yaml_sample
  end

  def create_from_zip_file
    Zip::File.open(yaml_sample_params[:file].open) do |zip_file|
      @yaml_samples = []
      zip_file.each do |yaml_file|
        # Move to next file if it's a directory, not a .yml file, or one of the funky osx files
        if yaml_file.ftype == :directory ||
           !yaml_file.name.match?(/(.yml)\z/) ||
           yaml_file.name.match?(/\A(__MACOSX)/)
          next
        end
        yaml_text = yaml_file.get_input_stream.read
        @yaml_samples << YamlSample.new(yaml_text)
      end
    end
    render "yaml_samples"
  end

  private

  def yaml_sample_params
    params.require(:yaml_sample).permit(:text, :file)
  end
end
