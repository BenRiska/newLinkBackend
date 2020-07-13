class UsersController < ApplicationController

    def index 
        users = User.all 
        render json: users, include: ["languages", "conversations", "messages"], :except => [:password_digest, :created_at, :updated_at]
    end

    def show 
        user = User.find(params[:id])
        render json: user, include: ["languages", "conversations", "messages"], :except => [:password_digest, :created_at, :updated_at]
    end

    def create
        user = User.create(name: params[:name], email: params[:email], password_digest: BCrypt::Password.create(params[:password]), username: params[:username], location: params[:location], bio: params[:bio])
        if user.valid?
          render json: user, status: :ok, :except => [:password_digest, :created_at, :updated_at]
        else
          render json: {data:user.errors},status: :unprocessable_entity
        end
    end

    def update

        pp params
        user = User.find(params[:id])
        # update logic
        user.name = params[:name]
        user.username = params[:username]
        user.email = params[:email]
        user.location = params[:location]
        user.bio = params[:bio]
        if user.save
          render json: user, include: ["languages", "conversations", "messages"], status: :ok, :except => [:password_digest, :created_at, :updated_at]
        else
          render json: {data:user.errors},status: :unprocessable_entity
        end
    end
end
