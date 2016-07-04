class ArticlesController < ApplicationController
  
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end
  # shows article after it is created by create action
  # A couple of things to note. We use Article.find to find the article we're 
  # interested in, passing in params[:id] to get the :id parameter from the request. 
  # We also use an instance variable (prefixed with @) to hold a reference to the article object. 
  # We do this because Rails will pass all instance variables to the view.
  def show
    @article = Article.find(params[:id])
  end
  # this creates an action taken from resources :article that directs user to the create new article page
  def new 
    @article = Article.new
  end
  def edit
    @article = Article.find(params[:id])
  end
  # creates the create action taken from resources :article
  def create
    @article = Article.new(article_params)
 
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
 
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
 
    redirect_to articles_path
  end
 
  private
    def article_params
      params.require(:article).permit(:title, :text)
      #rails requires for security reasons that we specify which fields in our articles form are allowed. 
      # This prevents malicious attack of sql injecting lot of other form fields that we don't want in our database table.
    end
  end
