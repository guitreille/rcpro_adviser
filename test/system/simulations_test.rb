require "application_system_test_case"

class SimulationsTest < ApplicationSystemTestCase
  setup do
    @simulation = simulations(:one)
  end

  test "visiting the index" do
    visit simulations_url
    assert_selector "h1", text: "Simulations"
  end

  test "should create simulation" do
    visit simulations_url
    click_on "New simulation"

    fill_in "Annual revenue", with: @simulation.annual_revenue
    fill_in "Entreprise no", with: @simulation.entreprise_no
    fill_in "Legal name", with: @simulation.legal_name
    fill_in "Nacebel codes", with: @simulation.nacebel_codes
    check "Natural person" if @simulation.natural_person
    click_on "Create Simulation"

    assert_text "Simulation was successfully created"
    click_on "Back"
  end

  test "should update Simulation" do
    visit simulation_url(@simulation)
    click_on "Edit this simulation", match: :first

    fill_in "Annual revenue", with: @simulation.annual_revenue
    fill_in "Entreprise no", with: @simulation.entreprise_no
    fill_in "Legal name", with: @simulation.legal_name
    fill_in "Nacebel codes", with: @simulation.nacebel_codes
    check "Natural person" if @simulation.natural_person
    click_on "Update Simulation"

    assert_text "Simulation was successfully updated"
    click_on "Back"
  end

  test "should destroy Simulation" do
    visit simulation_url(@simulation)
    click_on "Destroy this simulation", match: :first

    assert_text "Simulation was successfully destroyed"
  end
end
