require "rails_helper"

describe Blog::Category do
  it "has a valid factory" do
    expect(create(:category)).to be_valid
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:contentful_id) }
    it { should have_db_index(:contentful_id) }
    it { should validate_uniqueness_of(:contentful_id) }
  end
end
