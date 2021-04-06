# Copyright (c) 2021 Alexis Ramis.
# All Rights Reserved

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe CsvFilesController, 'Routes', type: :routing do
  # CRUD from resources
  it { is_expected.to route(:get, '/csv_files').to(action: 'index') }
  it { is_expected.to route(:post, '/csv_files').to(action: 'create') }
  it { is_expected.to route(:get, '/csv_files/new').to(action: 'new') }
  it { is_expected.to route(:get, '/csv_files/1/edit').to(action: 'edit', id: 1) }
  it { is_expected.to route(:get, '/csv_files/1').to(action: 'show', id: 1) }
  it { is_expected.to route(:put, '/csv_files/1').to(action: 'update', id: 1) }
  it { is_expected.to route(:patch, '/csv_files/1').to(action: 'update', id: 1) }
  it { is_expected.to route(:delete, '/csv_files/1').to(action: 'destroy', id: 1) }
end

RSpec.describe CsvFilesController, type: :controller do
  describe 'GET /' do
    context 'authenticated user' do
      login_user

      context do
        before { get :index }
        it { expect(response).to have_http_status(:success) }
      end
    end
  end
end
