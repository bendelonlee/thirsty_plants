require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :times_per_week}
    it { should validate_numericality_of(:times_per_week).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:times_per_week).is_less_than_or_equal_to(35) }
  end

  describe 'Relationships' do
    it { should belong_to :garden }
    it { should have_many :waterings }
  end

  describe 'callbacks' do
    it 'generates waterings after create' do
      plant = create(:plant, times_per_week: 5)
      expect(plant.reload.waterings.size).to eq(5)

      create(:watering, water_time: Date.yesterday, plant: plant)
      expect(plant.reload.waterings.size).to eq(6)
    end
  end
  describe 'instance methods' do
    it 'next_weeks_waterings' do
      plant_1 = create(:plant, times_per_week: 4)
      plant_1.reload
      plant_1.waterings.create!(water_time: (Date.today - 1.day))
      plant_1.waterings.create!(water_time: (Date.today + 2.weeks))
      expect(plant_1.next_weeks_waterings.count).to eq(4)
    end
    it 'projected_thirstiness_of_plant_on' do
      plant_1 = create(:plant, times_per_week: 4)
      plant_1.reload
      expect(plant_1.projected_thirstiness_of_plant_on(Date.today + 8)).to eq(1.1428571428571423)
      expect(plant_1.projected_thirstiness_of_plant_on(Date.today + 2)).to eq(0.7142857142857142)
      expect(plant_1.projected_thirstiness_of_plant_on(Date.today + 15)).to eq(5.142857142857142)
    end
  end
end
