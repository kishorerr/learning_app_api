require 'rails_helper'

RSpec.describe '/api/v1/subjects', type: :request do
  # initialize test data
  let!(:board) { create(:board) }
  let!(:s_class) { create(:s_class) }
  let!(:subjects) { create_list(:subject, 10, board_id: board_id,s_class_id: s_class_id ) }
  let(:board_id) { board.id }
  let(:s_class_id) { s_class.id }
  let(:subject_id) { subjects.first.id }

  # Test suite for GET /todos
  describe 'GET /api/v1/subjects' do
    # make HTTP get request before each example
    let(:valid_attributes) { { s_class_id:s_class_id, board_id:board_id } }
    before { get '/api/v1/subjects', params: valid_attributes  }

    it 'returns subjects belongs to that board and class' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty 
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /todos
  describe 'POST /api/v1/subjects' do
    # valid payload
    let(:valid_attributes) { { s_name: 'Maths', s_class_id:s_class_id, board_id:board_id  } }

    context 'when the request is valid' do
      before { post '/api/v1/subjects', params: valid_attributes }

      it 'creates a subject' do
        expect(json['s_name']).to eq('Maths')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/subjects', params: { s_name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /api/v1/subjects/:id' do
    let(:valid_attributes) { { s_name: 'Physics',s_class_id:s_class_id, board_id:board_id } }

    context 'when the record exists' do
      before { put "/api/v1/subjects/#{subject_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /api/v1/subjects/:id' do
    before { delete "/api/v1/subjects/#{subject_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end