describe Fraternity::TokenMismatchError do
  it "describes the mismatched tokens" do
    expected = "1234"
    actual = "5678"
    error = Fraternity::TokenMismatchError.new expected, actual
    (expect(error.message)).to eq "Expected token #{expected}, but was #{actual}"
  end
end
