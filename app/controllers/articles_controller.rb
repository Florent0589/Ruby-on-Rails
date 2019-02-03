class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  
  def index
    @articles = Article.all
  end

  # create form
  def new
    @article = Article.new
  end

  # edit resource display
  def edit
    @article = Article.find(params[:id])
  end

  # edit data
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  # store rsource data
  def create
    @article = Article.new(article_params)
    #@article = Article.new(params.require(:article).permit(:title, :text))

    # validates
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  # show resourse
  def show
    @article = Article.find(params[:id])
  end

  # delete
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end

end
