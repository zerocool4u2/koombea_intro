# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class CsvFilesController < ApplicationController
  before_action :authenticate_user!

  # GET /csv_files
  def index
    respond_to do |format|
      format.html do
        @pagy, @csv_files = pagy CsvFile.all
      end
    end
  end

  # GET /csv_files/1
  def show
    @csv_file = CsvFile.find(params[:id])
  end

  # GET /csv_files/new
  def new
    @csv_file = CsvFile.new
  end

  # GET /csv_files/1/edit
  def edit
    @csv_file = CsvFile.find(params[:id])
  end

  # POST /csv_files
  def create
    @csv_file = CsvFile.new(csv_file_params)

    respond_to do |format|
      format.html do
        if @csv_file.save
          flash_message_for @csv_file, :create, type: :notice
          redirect_to @csv_file
        else
          flash_message_for @csv_file, :create, request_method: :now, type: :alert
          render :new
        end
      end
    end
  end

  # PATCH/PUT /csv_files/1
  def update
    @csv_file = CsvFile.find(params[:id])

    respond_to do |format|
      format.html do
        if @csv_file.update(csv_file_params)
          # TODO move to job and evaluate on the background
          if @csv_file.parse_contacts.save
            flash_message_for @csv_file, :update, type: :notice
            redirect_to @csv_file
          else
            flash_message_for @csv_file, :update, request_method: :now, type: :alert
            render :edit
          end
        else
          flash_message_for @csv_file, :update, request_method: :now, type: :alert
          render :edit
        end
      end
    end
  end

  # DELETE /csv_files/1
  def destroy
    @csv_file = CsvFile.find(params[:id])

    respond_to do |format|
      format.html do
        if @csv_file.destroy
          flash_message_for @csv_file, :destroy, type: :notice
          redirect_to csv_files_url
        else
          flash_message_for @csv_file, :destroy, type: :error
          redirect_to @csv_file
        end
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def csv_file_params
    params.require(:csv_file).permit(
      :file, :headers, :headers_format, :name_column, :email_column, :birthday_column, :phone_column, :address_column, :credit_card_number_column,
      contacts_attributes: [
        :id, :name, :birthday, :phone, :address, :credit_card_number, :email, :_destroy
    ]
  )
  end
end
