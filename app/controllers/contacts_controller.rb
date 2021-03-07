# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class ContactsController < ApplicationController
  before_action :authenticate_user!

  # GET /contacts
  def index
    respond_to do |format|
      format.html do
        @pagy, @contacts = pagy Contact.all
      end
    end
  end

  # GET /contacts/1
  def show
    @contact = Contact.find(params[:id])
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # PATCH/PUT /contacts/1
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html do
        if @contact.update(contact_params)
          flash_message_for @contact, :update, type: :notice
          redirect_to @contact
        else
          flash_message_for @contact, :update, request_method: :now, type: :alert
          render :edit
        end
      end
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html do
        if @contact.destroy
          flash_message_for @contact, :destroy, type: :notice
          redirect_to contacts_url
        else
          flash_message_for @contact, :destroy, type: :error
          redirect_to @contact
        end
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params.require(:contact).permit(:email)
  end
end
