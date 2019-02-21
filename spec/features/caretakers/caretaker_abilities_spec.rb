require 'rails_helper'

describe 'As a caretaker of a garden' do
  it 'cannot delete that garden' do
    owner = create(:user)
    caretaker = create(:user, first_name: 'Caretaker')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(caretaker)
    garden = create(:garden, owners: [owner])
    create(:user_garden, garden: garden, user: caretaker, relationship_type: 'caretaker')
    own_garden = create(:garden, owners: [caretaker])
    
    visit garden_path(garden)
    
    expect(page).to_not have_button('Delete Garden')
  end
  it 'cannot update that garden' do
    owner = create(:user)
    caretaker = create(:user, first_name: 'Caretaker')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(caretaker)
    garden = create(:garden, owners: [owner])
    create(:user_garden, garden: garden, user: caretaker, relationship_type: 'caretaker')
    own_garden = create(:garden, owners: [caretaker])
    
    visit garden_path(garden)
    
    expect(page).to_not have_link('Update Garden Information')
  end
  it 'cannot add plants to that garden' do
    owner = create(:user)
    caretaker = create(:user, first_name: 'Caretaker')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(caretaker)
    garden = create(:garden, owners: [owner])
    create(:user_garden, garden: garden, user: caretaker, relationship_type: 'caretaker')
    own_garden = create(:garden, owners: [caretaker])
    
    visit garden_path(garden)
    
    expect(page).to_not have_link('Add a Plant to Your Garden!')
  end
end