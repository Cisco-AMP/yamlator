class YamlSamplesController < ApplicationController
  def create
    @yaml_sample = YamlSample.new(yaml_sample_params[:text])
    render @yaml_sample
  end

  private

  def yaml_sample_params
    params.require(:yaml_sample).permit(:text)
  end
end
