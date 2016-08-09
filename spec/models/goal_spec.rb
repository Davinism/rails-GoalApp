require 'rails_helper'

RSpec.describe Goal, type: :model do
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:privacy) }
  it { should validate_presence_of(:progress) }

  it { should validate_inclusion_of(:progress).in_range(0..100) }
  it { should validate_inclusion_of(:privacy).in_array(["private", "public"]) }

  it { should belong_to(:user) }
  it { should have_many(:comments) }
end
