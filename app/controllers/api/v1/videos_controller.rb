class Api::V1::VideosController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def index
        render json: Video.all
    end

    def show
        video = Video.find(params[:id])
        render json: video
    end

    def create
        video = Video.new(video_params)
        if video.save
            render status:200, json:{
                   message:"Sucessfully created videos ",
                   video: video
                }.to_json
        else
            render status:422, json:{
                   errors: video.errors
                }.to_json
        end
    end

    def destroy
        video = Video.find(params[:id])
        video.destroy
         render status:200,json:{     
                message:"Sucessfully deleted videos ",
                video: video
            }.to_json
    end

    private 

    def video_params
        params.require("video").permit("title")
    end
end
