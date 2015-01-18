describe Fraternity::Configuration do
  it "has a default send_invite proc" do
    configuration = Fraternity::Configuration.new
    expect { configuration.send_invite.call(nil) }.to_not raise_error
  end
end
