require 'rails_helper'

RSpec.describe EntriesController, type: :controller do

  let(:entry) do
    { 'name' => 'Car 1', 'score' => '10' }
  end

  describe 'GET show' do
    let(:get_service) { double }
    before do
      allow(Boards::GetService).to receive(:new) { get_service }
    end

    it 'calls the service' do
      expect(get_service).to receive(:execute).with(name: 'Car 1') { entry }
      get :show, id: entry['name']
    end

    describe 'formats' do
      before do
        allow(get_service).to receive(:execute) { entry }
      end

      context 'html' do
        it 'returns http success' do
          get :show, id: entry['name']
          expect(response).to have_http_status(:success)
        end
      end

      context 'json' do
        it 'returns http success' do
          get :show, id: 'entry', format: :json
          expect(response).to have_http_status(:success)
        end
      end

      describe 'when the entry is not found' do
        before do
          allow(get_service).to receive(:execute)
        end

        context 'JSON format' do
          it 'returns 404' do
            get :show, id: 'entry', format: :json
            expect(response).to have_http_status(:not_found)
          end
        end

        context 'HTML format' do
          it 'returns 404' do
            get :show, id: 'entry', format: :json
            expect(response).to have_http_status(:not_found)
          end
        end
      end
    end
  end

  describe 'POST create' do
    describe 'when the board does not exist' do
      let(:create_action) { double }

      before do
        allow(Boards::UpdateService).to receive(:new) { create_action }
      end

      it 'creates a new one' do
        expect(create_action).to receive(:execute).with(entry)
        post :create, entry: entry, format: :json
      end
    end
  end

  describe 'GET index' do
    let(:entries) do
      [
        { name: 'Car 1', score: 10, rank: 1 },
        { name: 'Car 2', score: 8, rank: 2 },
        { name: 'Car 3', score: 7, rank: 3 },
        { name: 'Car 4', score: 3, rank: 4 }
      ]
    end

    let(:get_service) { double }
    let(:options) { { page: 1, limit: 10 } }

    before do
      allow(Boards::GetService).to receive(:new) { get_service }
    end

    it 'calls the get service with right default parameters' do
      expect(get_service).to receive(:execute).with(options) { entries }
      get :index
    end

    context 'when the request asks for more than 100 entries' do
      it 'calls the action with 100' do
        options[:limit] = 100
        expect(get_service).to receive(:execute).with(options) { entries }
        get :index, limit: 100_000
      end
    end

    context 'when the request is out of range' do
      context 'HTML' do
        it 'returns 404' do
          allow(get_service).to receive(:execute).with(options) { [] }
          get :index, limit: 10
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'JSON' do
        it 'returns 404' do
          allow(get_service).to receive(:execute).with(options) { [] }
          get :index, limit: 10, format: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe 'DELETE name' do
    let(:delete_service) { double }

    before do
      allow(Boards::DeleteService).to receive(:new) { delete_service }
    end

    it 'calls the delete service' do
      expect(delete_service).to receive(:execute).with(name: 'entry') { entry }
      delete :destroy, id: 'entry'
    end

    context 'when the entry exists' do
      before do
        allow(delete_service).to receive(:execute).with(name: 'entry') { entry }
      end

      context 'HTML' do
        it 'redirects to leaderboard' do
          allow(delete_service).to receive(:execute).with('entry') { entry }
          delete :destroy, id: 'entry'
          expect(response).to have_http_status(:redirect)
        end
      end

      context 'JSON' do
        it 'returns 200' do
          delete :destroy, id: 'entry', format: :json
          expect(response).to have_http_status(:success)
        end
      end
    end

    context 'when the entry does not exist' do
      before do
        allow(delete_service).to receive(:execute).with(name: 'entry') {}
      end
      context 'HTML' do
        it 'returns 404' do
          delete :destroy, id: 'entry'
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'JSON' do
        it 'returns 200' do
          delete :destroy, id: 'entry', format: :json
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
