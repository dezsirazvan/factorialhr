require 'rails_helper'

RSpec.describe Metric, type: :model do
  subject { create(:metric) }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'is invalid' do
    subject.name = ''
    expect(subject).to_not be_valid
  end

  it 'is invalid' do
    subject.value = 'test'
    expect(subject).to_not be_valid
  end

  it 'is invalid' do
    subject.value = 3.5
    expect(subject).to_not be_valid
  end
end


