def load_repositories!
  require "lotus/model/adapters/memory_adapter"
  mapping = Fraternity::Repositories.mapping
  Fraternity::Repositories::PledgeRepository.adapter = Lotus::Model::Adapters::MemoryAdapter.new mapping
  mapping.load!
end
