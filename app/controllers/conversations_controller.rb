class ConversationsController < ApplicationController
    def index 
        conversations = Conversation.all 
        render json: conversations, include: ["users", "messages"]
    end

    def show 
        conversation = Conversation.find(params[:id])
        render json: conversation, include: ["users", "messages"]
    end

    def create
        conversation = Conversation.new(params)
        if conversation.save
          render json: conversation, include: ["users", "messages"], status: :ok
        else
          render json: {data:conversation.errors},status: :unprocessable_entity
        end
    end

    def update
        conversation = Conversation.find(params[:id])
        # update logic
        if conversation.save
          render json: conversation, include: ["users", "messages"], status: :ok
        else
          render json: {data:conversation.errors},status: :unprocessable_entity
        end
    end

    def destroy
        conversation = Conversation.find(params[:id])
        conversation.destroy
        render json: {status: 'SUCCESS', message:'Deleted rating', data: conversation}, status: :ok
      end
end
