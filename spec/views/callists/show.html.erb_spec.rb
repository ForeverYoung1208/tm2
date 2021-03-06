require 'rails_helper'

RSpec.describe "callists/show", :type => :view do
  before(:each) do
    @callist = assign(:callist, Callist.create!(
      :data => "MyText",
      :loadedby => nil,
      :isparsed => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
