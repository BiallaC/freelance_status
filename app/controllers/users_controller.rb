class UsersController < ApplicationController

	def new
		if params[:role] == "freelancer"
			@user = User.new	
			render 'new_freelancer'
		elsif params[:role] == "customer"
			@user = User.new
			render 'new_customer'
		end
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:sucess] = "You are sucessfully registered! Welcome to Freelance Status"
			redirect_to @user
		else
			if @user.role == "freelancer"
				render 'new_freelancer'
			elsif @user.role == "customer"
				render 'new_customer'
			end
		end
	end

	def show
		@user = User.find(params[:id])
		if @user.role == "freelancer"
			render 'show_freelancer'
		elsif @user.role == "customer"
			render 'show_customer'
		end
	end

	def edit
		
	end
end
