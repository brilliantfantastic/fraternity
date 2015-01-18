describe Fraternity::Repositories do
  describe ".initiation!" do
    it "sets the adapters for the repositories to a SQL adapter" do
      Fraternity::Repositories.initiation! "sqlite://blah.db"
      expect(Fraternity::Repositories::PledgeRepository.instance_variable_get("@adapter")).to be_instance_of Lotus::Model::Adapters::SqlAdapter
    end
  end
end
