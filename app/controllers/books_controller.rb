class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :check, only: [:update, :edit]
		def show
			@book = Book.find(params[:id])

		end

		def edit
			@book = Book.find(params[:id])
		end

		def index
			@books = Book.all
			@book = Book.new
		end
		def create
			@book = Book.new(book_params)
			@book.user_id = current_user.id
		if	@book.save
			flash[:notice] = "successfully"
			redirect_to book_path(@book)
		else 
			flash[:alart] = "error"
			redirect_to books_path
		end
		end
		def destroy
			book = Book.find(params[:id])
			book.destroy
			redirect_to books_path
		end
		def update
			book = Book.find(params[:id])
			if book.update(book_params)
			   flash[:notice] = "successfully"
			   redirect_to book_path(book)
			 else
			 	flash[:alart] = "error"
			 	@book = Book.find(params[:id])
			 	render :edit
			end
		end


	private
	def book_params
		params.require(:book).permit(:title, :body, :user_id)
	end
	def check
		book = Book.find(params[:id])
		if current_user.id != book.user_id
			redirect_to books_path
		end
	end
end
