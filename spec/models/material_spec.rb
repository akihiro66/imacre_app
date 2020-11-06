require 'rails_helper'

RSpec.describe Material, type: :model do
  let!(:material) { create(:material) }

  it "有効な状態であること" do
    expect(material).to be_valid
  end
end
