class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_tutor, only: [:new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @articles = Article.all
  end
  
  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.tutor_id = session[:tutor_id]
    
    if @article.save
      flash[:success] = "Article successfully created."
    else
      flash[:error] = "Oops! Article could not be added."
    end
    redirect_to articles_path
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article updated"
      redirect_to articles_path
    else
      flash[:danger] = "Something happened."
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article deleted"
    redirect_to articles_path
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body)
    end
    
    def set_article
      @article = Article.find(params[:id])
    end
    
    def require_same_user
      if session[:tutor_id] != @article.tutor_id
        flash[:danger] = "Unauthorized access"
        redirect_to articles_path
      end
    end
end
