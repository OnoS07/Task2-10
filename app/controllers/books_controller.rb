class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :ensure_correct_user, only:[:edit, :update]
	def ensure_correct_user
		@book = Book.find(params[:id])
		if current_user.id != @book.user_id
			redirect_to books_path
		end
	end

	def index
		@user = User.find(current_user.id)
		@book_new = Book.new
		@books = Book.all
	end

	def show
		@book = Book.find(params[:id])
		@user = User.find(@book.user_id)
		@book_new = Book.new

	    @comment = BookComment.new
	    @comments = @book.book_comments
	end

	def new
	end

	def create
		@book_new = Book.new(book_params)
		@book_new.user_id = current_user.id
		if @book_new.save
			flash[:notice] = "You have creatad book successfully."
			redirect_to book_path(@book_new)
		else
			@user = User.find(current_user.id)
			@books = Book.all
			render("books/index")
		end
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = "You have updated book successfully."
			redirect_to book_path(@book)
		else
			render("books/edit")
		end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		flash[:notice] = "You have destroyed book successfully."
		redirect_to books_path
	end

	protected
	def book_params
		params.require(:book).permit(:title, :body)
	end
end
