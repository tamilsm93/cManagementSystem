module Api
	class PostsController < ApplicationController

		skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
		
		def index
			@posts = Post.all
			render json: @posts
		end
	
		def create
			@post = Post.create(post_params)
			render json: @post
		end
	
		def show 
			@post = Post.find_by(id: params[:id])
			if !@post
				render json: { message: "post not found"}, status: :not_found
			else
				render json: @post
			end
		end
	
		def edit 
			@post = Post.find_by(params[:id])
		end
	
		def update 
			@post = Post.find_by(id: params[:id])
			if !@post
				render json: { message: "post not found"}, status: :not_found
			else
				@post.update(post_params)
				render json: @post
			end
		end
	
		def destroy
			@post = Post.find_by(id: params[:id])
			if @post
				@post.destroy
				render json:  {post: @post, message: "post deleted Successfully"}, status: :no_content
			else 
				render json: {error: "Post not found"}, status: :not_found
			end
		end
	
		private
		def post_params
			params.require(:post).permit(:title, :content, :category_id)
		end
	end
end