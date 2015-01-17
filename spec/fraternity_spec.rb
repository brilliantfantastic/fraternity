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
  end
end
