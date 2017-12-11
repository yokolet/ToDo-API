require 'rails_helper'

RSpec.describe Todo, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:order) }
  it { should validate_presence_of(:completed) }
end
