class ArticlesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :require_admin!, :except => [:show, :index]
  
  def index
    @articles = Article.recent.published

    respond_to do |format|
      format.html
      format.atom
    end
  end

  # TODO: move this to admin area
  def all
    @articles = Article.all

    render :action => 'index'
  end

  def show
    @article = Article.find(params[:id])

    if !params[:friendly] || !@article.friendly_id_status.best? ||
        @article.created_at.year != params[:year].to_i  ||
        @article.created_at.month != params[:month].to_i
      
      redirect_to friendly_article_path(@article), :status => :moved_permanently
    end
    
    if !@article.published && !(user_signed_in? && current_user.admin?)
      unauthorized!('This article has not published yet')
    end
  end

  def new
    @article = Article.new
  end

  def create
    unauthorized! if !current_user.admin?

    @article = Article.new(params[:article])
    @article.author = current_user
    if params[:preview].blank? && @article.save
      redirect_to friendly_article_path(@article)
    else
      render :action => :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    unauthorized! if !current_user.admin? && @article.author != current_user

    @article.attributes = params[:article]
    if params[:preview].blank? && @article.save
      redirect_to friendly_article_path(@article)
    else
      render :action => :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    unauthorized! if !current_user.admin? && @article.author != current_user
    
    @article.destroy
    
    redirect_to articles_path
  end

end
