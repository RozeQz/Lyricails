class LikesController < ApplicationController
  before_action :require_login

  def save_like
    @like = Like.new(post_id: params[:post_id], user_id: current_user.id)
    @post_id = params[:post_id]
    existing_like = Like.where(post_id: params[:post_id], user_id: current_user.id)
    
    respond_to do |format|
      format.js {
        if existing_like.any?
          existing_like.all.destroy_all
          @success = false
        else
          @like.save
          @success = true
        end

        render 'posts/like'
      }
    end
  end

  #   unless @like.save
  #     flash[:notice] = @like.errors.full_messages.to_sentence
  #   end

  #   redirect_to posts_path(@like.post, anchor: "post-#{@like.post.id}")
  # end

  # def destroy
  #   @like = current_user.likes.find(params[:id])
  #   post = @like.post
  #   @like.destroy
  #   redirect_to posts_path(post, anchor: "post-#{post.id}")
  # end

  # private
  
  # def like_params
  #   params.require(:like).permit(:post_id)
  # end
end