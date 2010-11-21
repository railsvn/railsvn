class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @article = Article.find(params[:article_id])
    unauthorized!('This article has not published yet') unless @article.published?

    redirect_to article_path(@article), :alert => 'comment must posted in article'
  end

  def create
    @article = Article.find(params[:article_id])
    unauthorized!('This article has not published yet') unless @article.published?
    
    @comment = @article.comments.build(params[:comment])
    @comment.author = current_user
    if @comment.save
      redirect_to article_path(@article), :notice => 'comment created'
    else
      render :action => 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    require_admin_or_author!(@comment)
  end

  def update
    @comment = Comment.find(params[:id])
    require_admin_or_author!(@comment)
    if @comment.update_attributes(params[:comment])
      redirect_to article_path(@comment.article), :notice => 'comment updated'
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    require_admin_or_author!(@comment)
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to @comment.article
  end

private
  def require_admin_or_author!(comment)
    unthorized! unless user_signed_in? && (current_user.admin? || comment.author == current_user)
  end
end
