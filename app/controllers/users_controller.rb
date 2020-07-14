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
        if User.checkParams(params)
        user = User.create(name: params[:name], email: params[:email], password_digest: BCrypt::Password.create(params[:password]), username: params[:username])
        end
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

    def login 
      pp params
        user = User.find_by(username: params[:username])
        if BCrypt::Password.new(user.password_digest) == params[:password]
          render json: user, include: ["languages", "conversations", "messages"], status: :ok, :except => [:password_digest, :created_at, :updated_at]
        else
          render json: {data: "Epic Fail"},status: :unprocessable_entity
        end
      end
  
      def language 
        pp params
        language = Language.find(params[:language])
        user = User.find(params[:user])
        Link.create(user: user, language: language)
        user.save
        render json: user, include: ["languages", "conversations", "messages"], status: :ok, :except => [:password_digest, :created_at, :updated_at]
      end
  
      def removelanguage 
        pp params
        user = User.find(params[:user])
        language = Language.find(params[:language])
        links = user.links
        link = links.select{|l| l.language_id == params[:language]}[0]
        link.destroy
        render json: user, include: ["languages", "conversations", "messages"], status: :ok, :except => [:password_digest, :created_at, :updated_at]
      end
  
      def filter
        user = User.find(params[:id])
        friends = user.conversations.map{|c| c.users}
        friends = friends.flatten.uniq
        users = User.all
        users = users.select{|u| !friends.include?(u)}
        
        render json: users, include: ["languages", "conversations", "messages"], status: :ok, :except => [:password_digest, :created_at, :updated_at]
      end
  
      def postfilter
        user = User.find(params[:user])
        language = Language.find(params[:language])
        users = User.all.select{|u| u.languages.include?(language)}
        users = users.filter{|u| u != user}
        render json: users, include: ["languages", "conversations", "messages"], status: :ok, :except => [:password_digest, :created_at, :updated_at]
      end

      def conversation 
        pp params
        user = User.find(params[:user])
        friend = User.find(params[:friend])
        convo = Conversation.create(group: false)
        Chatlink.create(user: user, conversation: convo)
        Chatlink.create(user: friend, conversation: convo)
        render json: user, include: ["languages", "conversations", "messages"], status: :ok, :except => [:password_digest, :created_at, :updated_at]
      end
  
      def chats 
        user = User.find(params[:id])
        conversations = user.conversations
        render json: conversations, include: ["users", "messages"], status: :ok, :except => [:password_digest, :created_at, :updated_at]
      end
  
      def message 
        reciever = User.find(params[:reciever])
        sender = User.find(params[:sender])
        conversation = Conversation.find(params[:conversation])
        Message.create(body: params[:body], conversation: conversation, user: sender, read: false)
        render json: conversation, include: ["users", "messages"], status: :ok, :except => [:password_digest, :created_at, :updated_at]
      end
  
      def destroy
          user = User.find(params[:id])
          user.destroy
          render json: {status: 'SUCCESS', message:'Deleted rating', data:user},status: :ok
        end
end
