require 'rails_helper'

RSpec.describe PasswordBuilder do
  
  it 'generates a new passwords' do
    words = "this,is,password"
    expect(PasswordBuilder.generate(words)).to eq (["thisispassword", "thispasswordis" ,"isthispassword", "ispasswordthis", "passwordthisis", "passwordisthis"])
  end

  it 'return nil' do
    words = "small,count"
    expect(PasswordBuilder.generate(words)).to eq nil
  end
end
