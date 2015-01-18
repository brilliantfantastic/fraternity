describe Fraternity do
  describe ".rush" do
    it "rushes with parameters that describe the pledge" do
      expect { Fraternity.rush email: "blah" }.to_not raise_error
    end

    it "creates a new pledge with the specified parameters" do
      pledge = Fraternity.rush email: "jimmy@example.com"
      expect(pledge.email).to eq "jimmy@example.com"
    end

    it "populates a token for the pledge to use for joining" do
      pledge = Fraternity.rush
      expect(pledge.token).to_not be_empty
    end

    it "uses the provided token if there is one" do
      pledge = Fraternity.rush token: "blah"
      expect(pledge.token).to eq "blah"
    end

    it "requires an email address" do
      pledge = Fraternity.rush
      expect(pledge).to_not be_valid
      expect(pledge.errors.for(:email).first.validation).to eq :presence
    end

    it "requires a valid email address" do
      pledge = Fraternity.rush email: "blah@test"
      expect(pledge).to_not be_valid
      expect(pledge.errors.for(:email).first.validation).to eq :format
    end

    it "requires a token" do
      pledge = Fraternity.rush email: "jimmy@example.com", token: ""
      expect(pledge).to_not be_valid
      expect(pledge.errors.for(:token).first.validation).to eq :presence
    end
  end

  describe ".rush!" do
    before do
      require "lotus/model/adapters/memory_adapter"
      mapping = Fraternity::Repositories.mapping
      Fraternity::Repositories::PledgeRepository.adapter = Lotus::Model::Adapters::MemoryAdapter.new mapping
      mapping.load!
    end

    it "creates a new pledge with the specified parameters" do
      pledge = Fraternity.rush! email: "jimmy@example.com"
      expect(pledge.email).to eq "jimmy@example.com"
    end

    it "saves the new pledge to the database" do
      pledge = Fraternity.rush! email: "jimmy@example.com"
      expect(pledge.id).to_not be_nil
    end
  end
end
