class ArticlesController < ApplicationController
  before_action :find_article, only: [:update, :edit, :show, :destroy]
  http_basic_authenticate_with name: "shubharthak", password: "abcd", except: [:index, :show]
  def index
    @articles = Article.all
  end

  def get_archived_posts
    @articles = Article.all
  end

  def change_to_public
    @article = Article.find(params[:article_id])
    @article.status = "public"
    if @article.save
      redirect_to articles_get_archived_posts_path

    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update

    if @article.update(article_params)
      redirect_to @article
    else
      render :new, status: :uunprocessable_entity
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
    def find_article
      @article = Article.find(params[:id])
    end
end