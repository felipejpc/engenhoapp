require "rails_helper"

describe Blog::Category do
  describe "validations" do
    subject { build(:category) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:contentful_id) }
    it { should have_db_index(:contentful_id) }
    it { should validate_uniqueness_of(:contentful_id) }

  end
end
