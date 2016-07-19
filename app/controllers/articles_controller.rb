class ArticlesController < ApplicationController
  before_action :set_article, except: [:new, :create, :index]
  before_action :tutor_signed_in?, only: [:new, :create]
  before_action :require_same_tutor, only: [:edit, :update, :destroy]
  
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
    @article.tutor_id = current_tutor.id
    
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
    
    def require_same_tutor
      if tutor_signed_in? and current_tutor.id != @article.tutor_id
        flash[:danger] = "Unauthorized access"
        redirect_to articles_path
      end
    end
end
