class MessagesController < ApplicationController
    def index 
        messages = Message.all 
        render json: messages, include: ["user", "conversation"]
    end

    def show 
        message = Conversation.find(params[:id])
        ender json: message, include: ["user", "conversation"]
    end

    def create
        message = Message.new(params)
        if message.save
          render json: message, include: ["user", "conversation"], status: :ok
        else
          render json: {data:message.errors},status: :unprocessable_entity
        end
    end

    def update
        message = Message.find(params[:id])
        # update logic
        if message.save
          render json: message, include: ["user", "conversation"], status: :ok
        else
          render json: {data:message.errors},status: :unprocessable_entity
        end
    end

    def destroy
        message = Message.find(params[:id])
        message.destroy
        render json: {status: 'SUCCESS', message:'Deleted rating', data: message}, status: :ok
      end
end
