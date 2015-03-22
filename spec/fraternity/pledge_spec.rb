describe Fraternity::Pledge do
  describe "validations" do
    it "requires an email address" do
      pledge = Fraternity::Pledge.new
      expect(pledge).to_not be_valid
      expect(pledge.errors.for(:email).first.validation).to eq :presence
    end

    it "requires a valid email address" do
      pledge = Fraternity::Pledge.new email: "blah@test"
      expect(pledge).to_not be_valid
      expect(pledge.errors.for(:email).first.validation).to eq :format
    end

    it "requires a token" do
      pledge = Fraternity::Pledge.new email: "jimmy@example.com", token: ""
      expect(pledge).to_not be_valid
      expect(pledge.errors.for(:token).first.validation).to eq :presence
    end

    it "requires an initiation number" do
      pledge = Fraternity::Pledge.new email: "jimmy@example.com", token: "123456", initiation_number: ""
      expect(pledge).to_not be_valid
      expect(pledge.errors.for(:initiation_number).first.validation).to eq :presence
    end
  end

  describe "#invited?" do
    it "is not invited if the date and time when they were invited is not set" do
      pledge = Fraternity::Pledge.new
      expect(pledge).to_not be_invited
    end

    it "is invited if the date and time when they were invited is set" do
      pledge = Fraternity::Pledge.new invited_at: DateTime.now
      expect(pledge).to be_invited
    end
  end

  describe "#invite!" do
    it "sets the date and time of when the pledge was invited to the current date and time" do
      pledge = Fraternity::Pledge.new
      pledge.invite!
      expect(pledge).to be_invited
    end
  end

  describe "#crossed?" do
    it "is not crossed if they have not accepted the invitation" do
      pledge = Fraternity::Pledge.new
      expect(pledge).to_not be_crossed
    end

    it "is crossed if they have accepted the invitation" do
      pledge = Fraternity::Pledge.new accepted_at: DateTime.now
      expect(pledge).to be_crossed
    end
  end

  describe "#cross!" do
    it "sets the date and time of when the pledge has accepted the invite to the current date and time" do
      load_repositories!
      token = "12345"
      pledge = Fraternity::Pledge.new token: token, invited_at: DateTime.now
      pledge.cross! token
      expect(pledge).to be_crossed
    end

    it "does not cross over if the token does not match" do
      pledge = Fraternity::Pledge.new token: "12345", invited_at: DateTime.now
      expect { pledge.cross! "blah" }.to raise_error Fraternity::TokenMismatchError
    end

    it "does not cross over if the pledge was not invited" do
      token = "12345"
      pledge = Fraternity::Pledge.new token: token
      expect { pledge.cross! token }.to raise_error Fraternity::PerpError
    end
  end

  describe "#bid!" do
    it "updates the date and time they were invited" do
      pledge = Fraternity::Pledge.new id: 123, token: "12345", email: "jimmy@example.com", invited_at: DateTime.new(2015, 1, 18)
      allow(Fraternity::Repositories::PledgeRepository).to receive(:persist).and_return pledge
      pledge.bid!
      expect(((DateTime.now - pledge.invited_at) * 24 * 60 * 60).to_i).to be < 1
    end
  end

  describe "#ready?" do
    it "returns true if the pledge is invited but not yet crossed" do
      pledge = Fraternity::Pledge.new token: "1234", invited_at: DateTime.now
      expect(pledge).to be_ready
    end

    it "is not ready if they have not been invited" do
      pledge = Fraternity::Pledge.new token: "1234"
      expect(pledge).to_not be_ready
    end

    it "is not ready if they have crossed" do
      pledge = Fraternity::Pledge.new token: "1234", invited_at: DateTime.now, accepted_at: DateTime.now
      expect(pledge).to_not be_ready
    end
  end

  describe "#merge" do
    it "updates attributes that were not set" do
      pledge = Fraternity::Pledge.new token: "1234"
      pledge.merge email: "jimmy@example.com"
      expect(pledge.email).to eq "jimmy@example.com"
    end

    it "updates attributes that were already set" do
      pledge = Fraternity::Pledge.new token: "1234"
      pledge.merge token: "5678"
      expect(pledge.token).to eq "5678"
    end

    it "does not delete attributes that were not set" do
      pledge = Fraternity::Pledge.new token: "1234", first_name: "Jimmy"
      pledge.merge email: "jimmy@example.com"
      expect(pledge.first_name).to eq "Jimmy"
    end
  end
end
