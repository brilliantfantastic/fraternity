describe Fraternity do
  describe ".rush" do
    it "rushes with parameters that describe the pledge" do
      expect { Fraternity.rush email: "blah" }.to_not raise_error
    end

    it "creates a new pledge with the specified parameters" do
      pledge = Fraternity.rush email: "jimmy@example.com"
      expect(pledge.email).to eq "jimmy@example.com"
    end
  end
end
