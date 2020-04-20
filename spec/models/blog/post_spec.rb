require "rails_helper"

describe Blog::Post do
  subject { build(:post) }

  describe "validations" do
    it { should validate_presence_of(:slug) }
    it { should validate_presence_of(:contentful_id) }
    it { should have_db_index(:slug) }
    it { should have_db_index(:contentful_id) }
    it { should have_db_index(:highlighted) }
    it { should validate_uniqueness_of(:slug) }
    it { should validate_uniqueness_of(:contentful_id) }
    it { should belong_to(:category) }
    it { should have_and_belong_to_many(:tags) }
  end

  describe "#json" do
    context "when json is not valid" do
      it "include a error message" do
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

  describe "#increment_views" do
    context "when there are no views" do
      it "returns one views count" do
        subject.increment_views

        expect(subject.views).to eq(1)
      end
    end

    context "when there are one or more views" do
      it "increment view count by one" do
        subject.update(views: 5)
        subject.increment_views

        expect(subject.views).to eq(6)
      end
    end
  end
end
