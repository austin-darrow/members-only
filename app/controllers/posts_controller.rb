class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]

    def index
        @posts = Post.all
        @user = current_user if user_signed_in?
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user
        
        if @post.save
            flash[:success] = "Great! Your post has been created!"
            redirect_to @post
        else
            flash.now[:error] = "Rats! Fix your mistakes, please."
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])

        if @post.update(post_params)
            redirect_to @post
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        
        redirect_to root_path, status: :see_other
    end

    private
    def post_params
        params.require(:post).permit(:title, :body, :user_id)
    end
end
