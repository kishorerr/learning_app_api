require 'rails_helper'

RSpec.describe '/api/v1/user_management/student/content_management/user_contents', type: :request do

  let!(:user) { create(:student) }
  let!(:valid_headers) { auth_headers(user) }
  let!(:student_enroll) { create(:student_enroll) } 
  let!(:board) { create(:board) }
  let!(:s_class) { create(:s_class, board_id: board_id) }
  let!(:subject) { create(:subject,s_class_id: s_class_id) }
  let!(:chapter) { create(:chapter,subject_id: subject_id ) }
  let!(:content) { create(:content, chapter_id: chapter_id ) }
  let(:board_id) { board.id }
  let(:s_class_id) { s_class.id }
  let(:subject_id) {subject.id }
  let(:chapter_id) { chapter.id }
  let(:content_id) {content.id}


  describe 'POST /api/v1/user_management/student/content_management/upvote' do
    let(:valid_attributes) { {  board_id:board_id } }
    context 'when the auth token is invalid or user isnt logged in' do
      before { post "/api/v1/user_management/student/content_management/upvote", params: valid_attributes, as: :json, headers: {'Authorizaton' => "foo"} }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST /api/v1/user_management/student/content_management/upvote' do
    let(:valid_attributes) { {  content_id: content_id } }
    context 'when the auth token is valid ' do
      before { post "/api/v1/user_management/student/content_management/upvote", params: valid_attributes, as: :json, headers: valid_headers[:auth]}
      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end
      it 'checks upvote is true' do
        expect(json['upvote']).to eq(true)
      end
    end
  end

  describe 'POST /api/v1/user_management/student/content_management/downvote' do
    let(:valid_attributes) { {  content_id: content_id } }
    context 'when the auth token is valid ' do
      before { post "/api/v1/user_management/student/content_management/downvote", params: valid_attributes, as: :json, headers: valid_headers[:auth]}
      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end
      it 'checks downvote is true' do
        expect(json['downvote']).to eq(true)
      end
    end
  end

  describe 'POST /api/v1/user_management/student/content_management/notes' do
    let(:valid_attributes) { {  content_id: content_id, notes: "Lorem Ipsum" } }
    context 'when the auth token is valid ' do
      before { post "/api/v1/user_management/student/content_management/notes", params: valid_attributes, as: :json, headers: valid_headers[:auth]}
      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end
      it 'checks for notes' do
        expect(json['notes']).to eq("Lorem Ipsum")
      end
    end
  end

  describe 'POST /api/v1/user_management/student/content_management/status' do
    let(:valid_attributes) { {  content_id: content_id, status: "completed" } }
    context 'when the auth token is valid ' do
      before { post "/api/v1/user_management/student/content_management/status", params: valid_attributes, as: :json, headers: valid_headers[:auth]}
      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end
      it 'checks updated status' do
        expect(json['status']).to eq("completed")
      end
    end
  end

  describe 'GET /api/v1/user_management/student/content_management/contents/:content_id' do
    let(:valid_attributes) { {  content_id: content_id } }
    context 'when the auth token is valid ' do
      before { get "/api/v1/user_management/student/content_management/contents/#{content_id}", headers: valid_headers[:auth]}
      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end
      it 'returns user content details' do
        expect(json).not_to be_empty
      end
    end
  end
 
end