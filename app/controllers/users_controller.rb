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
			log_in @user
			flash[:sucess] = "You are sucessfully registered! Welcome to Freelance Status!"
			redirect_to edit_user_path(@user)
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
		@user = User.find(params[:id])
		@freelancer_data = FreelancerData.find(@user.id)
		if @user.role == "freelancer"
			render 'edit_freelancer'
		elsif @user.role == "customer"
			render 'edit_customer'
		end
	end

  def update
    @user=User.find(params[:id])
    if @user.role = "freelancer"
    	if @user.freelancer_data.update_attributes(params[:freelancer_data])
      	flash[:success] = "Your profile was successfully updated!"
      	log_in @user
      	redirect_to user_path(@user)
    	else
      	render 'edit_freelancer'
      end
		elsif @user.role = "customer"
			#
		end
  end

end
