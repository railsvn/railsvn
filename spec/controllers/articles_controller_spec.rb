require "#{File.dirname(__FILE__)}/../spec_helper"

describe ArticlesController do

  describe "routing" do
    it_should_map_resources :articles, :subdomain => 'www'
  end

  describe "authorization" do
    it_should_require_logged_in_for :new, :create, :edit, :update, :destroy, :params => { :id => '123' }
    it_should_not_require_logged_in_for :index, :show, :params => { :id => '123' }
  end
  
  context 'with authenticated user,' do
    before(:each) do
      @current_user = Factory.create(:admin_user)
      sign_in :user, @current_user
    end

    describe "GET 'index'" do
      it "should assign variables" do
        @article = Factory.create(:article)
        get :index
        assigns(:articles).should == [@article]
      end

      it "should be success" do
        get :index
        response.should be_success
        response.should render_template('index')
      end
    end

    ['show', 'edit'].each do |action|
      describe "GET '#{action}'" do
        before(:each) do
          @article = Factory.create(:article)
          get action, :id => @article.id
        end

        it "should assign variables" do
          assigns(:article).should eql(@article)
        end
        it "should be success" do
          response.should be_success
          response.should render_template(action)
        end
      end
    end

    describe "GET 'new'" do
      it "should assign variables" do
        get :new
        assigns(:article).should be_an(Article)
        assigns(:article).should be_new_record
      end

      it "should be success" do
        get :new
        response.should be_success
        response.should render_template('new')
      end
    end

    describe "POST 'create'" do
      context "with valid params," do
        before(:each) do
          @model = mock_model(Article, {:save => true, :"author=" => nil })
          Article.should_receive(:new).with('these' => 'params').and_return(@model)
        end

        it "should assign a new article as @article" do
          post :create, :article => {'these' => 'params'}
          assigns[:article].should == @model
        end

        it "should redirect to the article for html format" do
          post :create, :article => {'these' => 'params'}, :format => 'html'
          response.should redirect_to(article_url(@model))
        end
      end

      context "with invalid params," do
        before(:each) do
          @model = mock_model(Article, {:save => false, :"author=" => nil})
          Article.should_receive(:new).with('these' => 'invalid params').and_return(@model)
        end

        it "should assign invalid article as @article" do
          post :create, :article => {'these' => 'invalid params'}
          assigns[:article].should eql(@model)
        end

        it "should re-render new template for html format" do
          post :create, :article => {'these' => 'invalid params'}, :format => 'html'
          response.should render_template('new')
        end
      end
    end

    describe "PUT 'update'" do
      context "with valid params," do
        before(:each) do
          @model = stub_model(Article, {:valid? => true})
          Article.stub(:find).with('article_id').and_return(@model)
        end

        it "should update article" do
          @model.should_receive(:attributes=).with({'these' => 'params'})
          put :update, :id => 'article_id', :article => {'these' => 'params'}
        end

        it "should assign the updated article as @article" do
          put :update, :id => 'article_id', :article => {'these' => 'params'}
          assigns[:article].should eql(@model)
        end

        it "should redirect to the article for html format" do
          put :update, :id => 'article_id', :article => {'these' => 'params'}, :format => 'html'
          response.should redirect_to(article_url(@model))
        end
      end

      context "with invalid params," do
        before(:each) do
          @model = stub_model(Article, {:valid? => false})
          Article.stub(:find).with('article_id').and_return(@model)
        end

        it "should assign the updated article as @article" do
          put :update, :id => 'article_id', :article => {'these' => 'params'}
          assigns[:article].should eql(@model)
        end

        it "should re-render edit template for html format" do
          put :update, :id => 'article_id', :article => {'these' => 'params'}, :format => 'html'
          response.should render_template('edit')
        end
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) do
        @model = mock_model(Article)
        Article.stub(:find).with('article_id').and_return(@model)
      end

      it "should delete article" do
        @model.should_receive(:destroy)
        delete :destroy, :id => 'article_id'
      end

      it "should redirect to list of articles for html format" do
        delete :destroy, :id => 'article_id'
        response.should redirect_to(articles_url)
      end
    end
  end
end
