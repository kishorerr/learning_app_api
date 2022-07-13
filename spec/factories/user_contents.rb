FactoryBot.define do
    factory :user_content do
      upvote {"true"}
      downvote {"false"}
      status {"not_started"}
    end
  end