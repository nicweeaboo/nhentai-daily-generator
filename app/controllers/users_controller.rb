require 'open-uri'
class UsersController < ApplicationController
  def index
    @doujinshi = Doujinshi.new(Time.now.strftime("%m%d%y").to_i)
    if @doujinshi.client.code == '200'
      @format = @doujinshi.cover.split('cover.').last
      unless File.exists?("public/covers/#{@doujinshi.id}.#{@format}")
        open("public/covers/#{@doujinshi.id}.#{@format}", 'wb') {|file| file << open(@doujinshi.cover).read}
      end
    end
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash.now[:notice] = "Pawsome! #{@user.email} will now receive the everyday doujinshi"
      render "index"
    else
      flash.now[:alert] = "Sorry. Something went wrong. #{@user.email}.."
      render "index"
    end
  end
  def unsubscribe
    @user = User&.find_by(email: params[:email])
    unless @user
      flash[:notice] = "This user was already unsubscribed"
      redirect_to root_path
    end
  end
  def destroy
    @user = User&.find(params[:id])

    if @user.destroy
      flash[:notice] = "Incoming cat knowledge cancelled! #{@user.email} has been successfully unsubscribed"
      redirect_to root_path
    else
      flash.now[:alert] = "Sorry! #{@user.email} couldn't be unsubscribed. Please contact perfectplastic.undefined@gmail.com if the problem persists."
    end
  end

  private
  def user_params
    params.require(:user).permit(:email)
  end
end
