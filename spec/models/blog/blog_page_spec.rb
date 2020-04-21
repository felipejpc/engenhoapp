require "rails_helper"

describe Blog::BlogPage do
  subject { build(:blog_page) }

  it "has a valid factory" do
    expect(create(:blog_page)).to be_valid
  end

  describe "validations" do
    it { should validate_presence_of(:slug)}
    it { should validate_presence_of(:contentful_id)}
    it { should validate_presence_of(:json) }
    it { should validate_presence_of(:type) }
    it { should have_db_index(:slug) }
    it { should have_db_index(:contentful_id) }
    it { should have_db_index(:type) }
    it { should validate_uniqueness_of(:slug) }
    it { should validate_uniqueness_of(:contentful_id) }
  end

  describe "#json" do
    context "when json is not valid" do
      it "includes a error message" do
        subject.json = {"other_json_format"=> {} }
        subject.valid?

        expect(subject.errors[:json]).to include('Must be a custom_json format. Use ContentfulCustomJson class to format json correctly')
      end
    end

    context "when json is valid" do
      it "does not include a error message" do
        subject.valid?

        expect(subject.errors[:json]).to_not include('Must be a custom_json format. Use ContentfulCustomJson class to format json correctly')
      end
    end
  end
end
