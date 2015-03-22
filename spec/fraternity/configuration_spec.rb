describe Fraternity::Configuration do
  it "has a default send_invite proc" do
    configuration = Fraternity::Configuration.new
    expect { configuration.send_invite.call(nil) }.to_not raise_error
  end

  it "has a default receive_pledge proc" do
    configuration = Fraternity::Configuration.new
    expect { configuration.receive_pledge.call(nil) }.to_not raise_error
  end
end
