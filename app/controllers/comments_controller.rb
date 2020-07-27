class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      flash[:success] = "Comment successfuly created"
    else
      if @comment.body.blank?
        flash[:warning] = "Comment must not be empty"
      else
        flash[:warning] = "You commented on this chapter"
      end
    end
    redirect_to request.referer
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :chapter_id)
    end
end
