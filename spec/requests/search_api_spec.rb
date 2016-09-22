require 'rails_helper'

describe "search API" do
  before(:each) do
    tutor1 = FactoryGirl.create(:tutor, name: "Geralt", city: "Vengerberg")
    tutor2 = FactoryGirl.create(:tutor, name: "Yennefer", city: "Vengerberg")
    tutor3 = FactoryGirl.create(:tutor, name: "Vesemir")
    subject = Subject.create!(tutor_id: tutor2.id, grade: "9", name: "Spells")
  end
  
  it "search by name" do
    get '/search.json?search=Yennefer'
    json = JSON.parse(response.body)
    
    expect(json.length).to eql(1)

    expect(json[0]["name"]).to eql("Yennefer") # json[0].name won't work
    expect(json[0]["subjects"].length).to eql(1)
    expect(json[0].has_key?("email")).to be false
    expect(json[0].has_key?("encrypted_password")).to be false
  end
  
  it "search by city" do
    get '/search.json?search=Vengerberg'
    json = JSON.parse(response.body)
    
    expect(json.length).to eql(2)
    expect(json[0]["name"]).to eql("Geralt")
    expect(json[1]["name"]).to eql("Yennefer")
  end
  
end