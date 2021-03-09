# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /users
  def index
    @pagy, @users = pagy User.all

    respond_to do |format|
      format.html

      format.js do
        render inline: render_list
      end
    end
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PATCH/PUT /users/1
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      format.html do
        if @user.update(user_params)
          flash_message_for @user, :update, type: :notice
          redirect_to @user
        else
          flash_message_for @user, :update, request_method: :now, type: :alert
          render :edit
        end
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])

    respond_to do |format|
      format.html do
        if @user.destroy
          flash_message_for @user, :destroy, type: :notice
          redirect_to users_url
        else
          flash_message_for @user, :destroy, type: :error
          redirect_to @user
        end
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email)
  end
end
