class PostsController < ApplicationController
    #http_basic_authenticate_with name: "omedale", password: "medale", except: [:index, :show]
    include PostsHelper
    def index
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
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
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
        @post = Post.new(post_params)
        @post.user = User.first
                
        if(@post.save)
            flash[:success] = "Post saved successfully"
            redirect_to @post
        else
            render 'new'
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        
        if(@post.update(post_params))
            flash[:success] = "Post update  successfully"
            redirect_to @post
        else
            render 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        flash[:danger] = "Post deleted successfully"
        redirect_to posts_path
    end

    private def post_params
        params.require(:post).permit(:title, :body)
    end
end
