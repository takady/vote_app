require 'rails_helper'

RSpec.describe 'Races', type: :request do
  let(:user) { create(:user) }

  # TODO fix
  before do
    allow_any_instance_of(Api::ApiController).to receive(:current_user).and_return(user)
  end

  describe 'POST /api/races' do
    let(:title) { 'Title' }
    let(:expired_at) { Time.current + 1.month }
    let(:candidates) {
      [
        {name: 'one', order: 1},
        {name: 'two', order: 2}
      ]
    }

    subject {
      post api_races_path,
           params: {
             title: title,
             expired_at: expired_at,
             candidates: candidates
           },
           as: :json
    }

    context 'Valid parameter' do
      it { is_expected.to eq(201) }
    end

    context 'blank title' do
      let(:title) { '' }

      it { is_expected.to eq(400) }
    end

    context 'less than two candidates' do
      let(:candidates) {
        [
          {name: 'one', order: 1}
        ]
      }

      it { is_expected.to eq(400) }
    end
  end
end
