require 'rails_helper'

RSpec.describe '/api/v1/meta/boards', type: :request do
 
  let!(:boards) { create_list(:board, 10) }
  let(:board_id) { boards.first.id }

  
  describe 'GET /api/v1/meta/boards' do
    
    before { get '/api/v1/meta/boards' }

    it 'returns boards' do
     
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/meta/boards/:board_id' do
    before { get "/api/v1/meta/boards/#{board_id}" }

    context 'when todo item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(board_id)
      end
    end
  end

  describe 'POST /api/v1/meta/boards' do
   
    let(:valid_attributes) { { b_name: 'ICSE', b_desc: 'Lorem Ipsum' } }

    context 'when the request is valid' do
      before { post '/api/v1/meta/boards', params: valid_attributes }

      it 'creates a board' do
        expect(json['b_name']).to eq('ICSE')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/meta/boards', params: { b_name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  
  describe 'PUT /api/v1/meta/boards/:id' do
    let(:valid_attributes) { { b_name: 'CBSE' } }

    context 'when the record exists' do
      before { put "/api/v1/meta/boards/#{board_id}", params: valid_attributes }

      it 'updates the record' do
        expect(json['b_name']).to eq("CBSE")
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  
  describe 'DELETE /api/v1/meta/boards/:id' do
    before { delete "/api/v1/meta/boards/#{board_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end