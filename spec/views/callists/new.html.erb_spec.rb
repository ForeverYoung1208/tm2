require 'rails_helper'

RSpec.describe "callists/new", :type => :view do
  before(:each) do
    assign(:callist, Callist.new(
      :data => "MyText",
      :loadedby => nil,
      :isparsed => false
    ))
  end

  it "renders new callist form" do
    render

    assert_select "form[action=?][method=?]", callists_path, "post" do

      assert_select "textarea#callist_data[name=?]", "callist[data]"

      assert_select "input#callist_loadedby[name=?]", "callist[loadedby]"

      assert_select "input#callist_isparsed[name=?]", "callist[isparsed]"
    end
  end
end
