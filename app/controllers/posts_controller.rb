class PostsController < ApplicationController
    #http_basic_authenticate_with name: "omedale", password: "medale", except: [:index, :show]
    before_action :set_post, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_owner, only: [:edit, :update, :destroy]
    include PostsHelper
    def index
        redirect_to posts_path if logged_in?
        @posts = Post.paginate(page: params[:page], per_page: 2 )
        #puts 'hello word'
        #puts '--------------'
        user_email = 'oluwafemi.medale@andela.com'
        puts andelan? user_email
        #puts '------==--------'
        #addit? 2, 3
        #say_hi("thank u for helping")
    end

    def posts
        @posts = Post.paginate(page: params[:page], per_page: 2 )
    end

    def show
        puts "========777================="
        puts @post.to_json
    end

    def new
        @post = Post.new
    end

    def andelan?(email)
        #checks if andela.com is available in the email sent to this function
        email["andela.com"] ? true : false
    end

    def addit?(a, b)
        k = "yeo"
        puts "#{a} ==== #{b}"
        puts "#{a} ="+ k + "=== #{b}"
    end

    def create
        #render plain: params[:post].inspect
       if logged_in?
            @post = Post.new(post_params)
            @post.user = current_user
                    
            if(@post.save)
                flash[:success] = "Post saved successfully"
                redirect_to @post
            else
                render 'new'
            end
        else
            require_user
        end
    end

    def edit

    end

    def update
       if(@post.update(post_params))
            flash[:success] = "Post update  successfully"
            redirect_to @post
        else
            render 'edit'
        end
    end

    def destroy
        @post.destroy
        flash[:danger] = "Post deleted successfully"
        redirect_to posts_path
    end

    private def post_params
        params.require(:post).permit(:title, :body)
    end

    def set_post
        @comment = Comment.new
        @post = Post.find(params[:id])
    end

    def require_owner
        if logged_in? && current_user != @post.user 
            flash[:danger] = "You can only edit or delete your own articles"           
            redirect_to home_path
        end
    end
end
