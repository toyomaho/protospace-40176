class PrototypesController < ApplicationController

  def index
    @prototype =Prototype.all
    @user = User.new
  end

  def new
    @prototype = Prototype.new
  end

  def create
    if user_signed_in?
      @prototype = Prototype.new(prototype_params)
      if @prototype.save
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    if user_signed_in?
      @prototype = Prototype.find(params[:id])
      unless current_user.id == @prototype.user_id
        redirect_to action: :index
      end
    else
      redirect_to new_user_session_path
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to action: :show
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def destroy
    if user_signed_in?
      @prototype = Prototype.find(params[:id])
      @prototype.comments.destroy
      @prototype.destroy
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
  end
  
end
