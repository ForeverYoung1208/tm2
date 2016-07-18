require 'rails_helper'

RSpec.describe "callists/edit", :type => :view do
  before(:each) do
    @callist = assign(:callist, Callist.create!(
      :data => "MyText",
      :loadedby => nil,
      :isparsed => false
    ))
  end

  it "renders the edit callist form" do
    render

    assert_select "form[action=?][method=?]", callist_path(@callist), "post" do

      assert_select "textarea#callist_data[name=?]", "callist[data]"

      assert_select "input#callist_loadedby[name=?]", "callist[loadedby]"

      assert_select "input#callist_isparsed[name=?]", "callist[isparsed]"
    end
  end
end
