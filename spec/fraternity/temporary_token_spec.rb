describe Fraternity::TemporaryToken do
  describe ".generate_random_token" do
    it "generates a unique random token" do
      tokens = []
      50.times { tokens << Fraternity::TemporaryToken.generate_random_token }
      expect(tokens.uniq.length).to eq 50
    end
  end
end
