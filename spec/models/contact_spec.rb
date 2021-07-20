require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject { create(:contact) }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'is invalid' do
    subject.first_name = ''
    expect(subject).to_not be_valid
  end

  it 'is invalid' do
    subject.last_name = ''
    expect(subject).to_not be_valid
  end

  it 'is invalid' do
    subject.email = ''
    expect(subject).to_not be_valid
  end
end


