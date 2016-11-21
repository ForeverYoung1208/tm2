require 'rails_helper'

RSpec.describe "callists/index", :type => :view do
  before(:each) do
    assign(:callists, [
      Callist.create!(
        :data => "MyText",
        :loadedby => nil,
        :isparsed => false
      ),
      Callist.create!(
        :data => "MyText",
        :loadedby => nil,
        :isparsed => false
      )
    ])
  end

  it "renders a list of callists" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
