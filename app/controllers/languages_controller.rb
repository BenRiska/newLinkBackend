class LanguagesController < ApplicationController
    def index 
        languages = Language.all 
        render json: languages, include: ["users"]
    end

    def show 
        language = Language.find(params[:id])
        render json: language, include: ["users"]
    end
end
