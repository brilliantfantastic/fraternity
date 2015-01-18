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

    it "creates an initiation number" do
      pledge = Fraternity.rush
      expect(pledge.initiation_number).to_not be_nil
      initiated_at = Time.at pledge.initiation_number
      expect((Time.now - initiated_at).to_i).to be < 1
    end

    it "uses the provided initiation number if there is one" do
      pledge = Fraternity.rush initiation_number: 12345
      expect(pledge.initiation_number).to eq 12345
    end
  end

  describe ".rush!" do
    before { load_repositories! }

    it "creates a new pledge with the specified parameters" do
      pledge = Fraternity.rush! email: "jimmy@example.com"
      expect(pledge.email).to eq "jimmy@example.com"
    end

    it "saves the new pledge to the database" do
      pledge = Fraternity.rush! email: "jimmy@example.com"
      expect(pledge.id).to_not be_nil
    end
  end

  describe ".configure" do
    it "yields an instance of configuration" do
      Fraternity.configure(false) do |config|
        expect(config).to eq Fraternity.configuration
      end
    end
  end

  describe ".bid!" do
    let(:pledge) { Fraternity::Repositories::PledgeRepository.create(Fraternity::Pledge.new(email: "jimmy@example.com", token: "1234", initiation_number: Time.now.to_i)) }

    before do
      load_repositories!
      pledge
    end

    it "invites the uninvited" do
      pledges = Fraternity.bid! 5
      expect(pledges.to_a[0].id).to eq pledge.id
      expect(pledges.to_a[0]).to be_invited
    end

    it "sends the invite" do
      sent_invite = false
      Fraternity.configure(false) do |c|
        c.send_invite = lambda do |pledge|
          sent_invite = true
        end
      end
      pledges = Fraternity.bid! 5
      expect(sent_invite).to be true
    end
  end
end
