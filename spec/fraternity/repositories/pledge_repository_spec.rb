describe Fraternity::Repositories::PledgeRepository do
  before { load_repositories! }

  describe ".find_by_token" do
    let(:token) { "YUSGH764" }
    let(:pledge) { Fraternity::Repositories::PledgeRepository.create(Fraternity::Pledge.new(email: "jimmy@example.com", token: token, initiation_number: Time.now.to_i)) }

    it "returns the first pledge with the token" do
      pledge
      actual = Fraternity::Repositories::PledgeRepository.find_by_token token
      expect(actual.id).to eq pledge.id
    end

    it "returns nil if the pledge does not exist" do
      actual = Fraternity::Repositories::PledgeRepository.find_by_token "blah"
      expect(actual).to be_nil
    end
  end

  describe ".oldest_univited_by_initiation_number" do
    let(:four_days_ago) { Time.now.to_i - 24 * 60 * 60 * 4 }
    let(:six_days_ago) { Time.now.to_i - 24 * 60 * 60 * 6 }
    let(:ten_days_ago) { Time.now.to_i - 24 * 60 * 60 * 10 }

    let(:oldest_pledge) { Fraternity::Repositories::PledgeRepository.create(Fraternity::Pledge.new(email: "jimmy@example.com", token: "1234", initiation_number: ten_days_ago)) }
    let(:middle_pledge) { Fraternity::Repositories::PledgeRepository.create(Fraternity::Pledge.new(email: "robert@example.com", token: "5678", initiation_number: six_days_ago)) }
    let(:newest_pledge) { Fraternity::Repositories::PledgeRepository.create(Fraternity::Pledge.new(email: "john@example.com", token: "9123", initiation_number: four_days_ago)) }

    before { [middle_pledge, newest_pledge, oldest_pledge] } # place in database in this order

    it "returns the oldest pledges based on their initiation number" do
      pledges = Fraternity::Repositories::PledgeRepository.oldest_uninvited_by_initiation_number
      expect(pledges.map(&:email)).to eq ["jimmy@example.com", "robert@example.com", "john@example.com"]
    end

    it "returns a limited number of pledges" do
      pledges = Fraternity::Repositories::PledgeRepository.oldest_uninvited_by_initiation_number(2)
      expect(pledges.map(&:email)).to eq ["jimmy@example.com", "robert@example.com"]
    end
  end
end
