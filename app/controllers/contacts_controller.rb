# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class ContactsController < ApplicationController
  before_action :authenticate_user!

  # GET /contacts
  def index
    @pagy, @contacts = pagy Contact.active

    respond_to do |format|
      format.html

      format.js do
        render inline: render_list
      end
    end
  end

  # GET /contacts/1
  def show
    @contact = Contact.find(params[:id]).decorate
  end

  # GET /contacts/new
  def new
    @contact = Contact.new.decorate
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id]).decorate
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params).decorate

    respond_to do |format|
      format.html do
        if @contact.save
          flash_message_for @contact, :create, type: :notice
          redirect_to @contact
        else
          flash_message_for @contact, :create, request_method: :now, type: :alert
          render :new
        end
      end
    end
  end

  # PATCH/PUT /contacts/1
  def update
    @contact = Contact.find(params[:id]).decorate

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
