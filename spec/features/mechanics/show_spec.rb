require 'rails_helper'

RSpec.describe 'Mechanic Show Page' do
  before :each do
    @mech_1 = Mechanic.create!(name: 'Roald', years_experience: 25)
    @mech_2 = Mechanic.create!(name: 'Larry', years_experience: 10)
    @mech_3 = Mechanic.create!(name: 'Samantha', years_experience: 30)

    @ride_1 = Ride.create!(name: 'ThrillHouse', thrill_rating: 4, open: true)
    @ride_2 = Ride.create!(name: 'Thrillinator 500', thrill_rating: 7, open: true)
    @ride_3 = Ride.create!(name: 'Merry-go-round', thrill_rating: 1, open: false)
    @ride_4 = Ride.create!(name: 'The Closed Ride', thrill_rating: 0, open: false)

    @r_m_1 = RideMechanic.create!(ride_id: @ride_1.id, mechanic_id: @mech_1.id)
    @r_m_2 = RideMechanic.create!(ride_id: @ride_2.id, mechanic_id: @mech_1.id)
    @r_m_3 = RideMechanic.create!(ride_id: @ride_2.id, mechanic_id: @mech_2.id)
    @r_m_4 = RideMechanic.create!(ride_id: @ride_2.id, mechanic_id: @mech_3.id)
    @r_m_5 = RideMechanic.create!(ride_id: @ride_3.id, mechanic_id: @mech_3.id)
    @r_m_5 = RideMechanic.create!(ride_id: @ride_1.id, mechanic_id: @mech_3.id)

    visit "/mechanics/#{@mech_3.id}"
  end

  it 'shows name, years experience, and rides they are working on' do

    expect(page).to have_content(@mech_3.name)
    expect(page).to have_content(@mech_3.years_experience)
    expect(page).to have_content(@ride_2.name)
    expect(page).to_not have_content(@ride_1.name)
  end

  it 'Only shows open rides' do

    expect(page).to_not have_content(@ride_3.name)
  end

  it 'shows rides listed by thrill rating in descending order' do

    expect(page).to have_content('First')
  end
end