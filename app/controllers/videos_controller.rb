class VideosController < ApplicationController
  before_action :set_video, only: %i[ show ]

  # GET /videos or /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1 or /videos/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params.expect(:id))
    end
end
