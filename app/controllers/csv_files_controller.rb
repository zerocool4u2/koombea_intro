# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

class CsvFilesController < ApplicationController
  before_action :authenticate_user!

  # GET /csv_files
  def index
    @pagy, @csv_files = pagy CsvFile.all

    respond_to do |format|
      format.html

      format.js do
        render inline: render_list
      end
    end
  end

  # GET /csv_files/1
  def show
    @csv_file = CsvFile.includes(:contacts).find(params[:id]).decorate
  end

  # GET /csv_files/new
  def new
    @csv_file = CsvFile.new.decorate
  end

  # GET /csv_files/1/edit
  def edit
    @csv_file = CsvFile.includes(:contacts).find(params[:id]).decorate
    @csv_file.valid?
  end

  # POST /csv_files
  def create
    @csv_file = CsvFile.new(csv_file_params).decorate

    respond_to do |format|
      format.html do
        if @csv_file.save
          CsvParserJob.perform_later(@csv_file)
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
    @csv_file = CsvFile.find(params[:id]).decorate

    respond_to do |format|
      format.html do
        if @csv_file.update(csv_file_params)
          CsvParserJob.perform_later(@csv_file)
          flash_message_for @csv_file, :update, type: :notice
          redirect_to @csv_file
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
      :file, :headers, :headers_format, :name_column, :birthday_column, :phone_column, :address_column, :credit_card_number_column, :email_column,
      contacts_attributes: [
        :id, :name, :birthday, :phone, :address, :credit_card_number, :email, :_destroy
    ]
  )
  end
end
