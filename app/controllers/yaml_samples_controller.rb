require 'zip'

class YamlSamplesController < ApplicationController
  MAX_FILE_COUNT = 125

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
    render "yaml_sample"
  end

  def create_from_yaml_file
    yaml_file = yaml_sample_params[:file]
    @yaml_sample = YamlSample.new(yaml_file.read, yaml_file.original_filename)
    render "yaml_sample"
  end

  def create_from_zip_file
    Zip::File.open(yaml_sample_params[:file].open) do |zip_file|
      @yaml_samples = []
      file_count = 0
      zip_file.each do |yaml_file|
        # Don't parse any directories or funky macOS zip things.
        # Only parse YAML files.
        if yaml_file.ftype == :directory ||
           yaml_file.name.match?(/\A(__MACOSX)/) ||
           !yaml_file.name.match?(/(.yml)\z/)
          next
        end
        break if file_count == MAX_FILE_COUNT
        yaml_text = yaml_file.get_input_stream.read
        @yaml_samples << YamlSample.new(yaml_text, yaml_file.name)
        file_count += 1
      end
    end
    render "yaml_samples"
  end

  private

  def yaml_sample_params
    params.require(:yaml_sample).permit(:text, :file)
  end
end
