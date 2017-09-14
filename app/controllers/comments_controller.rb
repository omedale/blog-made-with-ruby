class CommentsController < ApplicationController
 
    def create
        @post = Post.find(params[:post_id])
        if logged_in?
            @comment = @post.comments.new(comment_params)
            @comment.username = current_user.username
            if @comment.save
                redirect_to post_path(@post)
            else
                msg = "Oooops! ....Error!"  
                redirect_to ("/posts/#{@post.id}"), flash: { danger: msg }
            end
        else
            @comment = @post.comments.create(comment_params)
            unless @comment.errors.full_messages[0]
                redirect_to ("/posts/#{@post.id}")
            else
                msg = @comment.errors.full_messages[0]
                redirect_to ("/posts/#{@post.id}"), flash: { danger: msg }
            end
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
    end

    private def comment_params
        params.require(:comment).permit(:username, :body)
    end
end
