class ArticlesController < ApplicationController
  before_action :find_article, only: [:update, :edit, :show, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @articles = Article.all
  end

  def get_archived_posts
    @articles = Article.where(user_id: current_user.id)
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
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
    #if @article.save
    #  redirect_to @article
    #else
    #  render :new, status: :unprocessable_entity
    #end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
    #if @article.update(article_params)
    #  redirect_to @article
    #else
    #  render :new, status: :uunprocessable_entity
    #end
  end

  def destroy
    @article.destroy

    #redirect_to root_path, status: :see_other
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Article was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :user_id)
    end
    def find_article
      @article = Article.find(params[:id])
    end
end