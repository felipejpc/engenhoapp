require "rails_helper"

describe Blog::Tag do
  describe "validations" do
    subject { build(:tag) }

    it { should validate_presence_of(:contentful_id) }
    it { should validate_presence_of(:tag_name) }
    it { should have_db_index(:contentful_id) }
    it { should have_db_index(:tag_name) }
    it { should validate_uniqueness_of(:tag_name) }
    it { should validate_uniqueness_of(:contentful_id) }
  end
end
