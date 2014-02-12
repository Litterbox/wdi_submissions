require 'spec_helper'

describe Instructor do
	it 'sets a first_name from the name' do
		ins = FactoryGirl.create(:instructor, :name => "Raphael Sofaer")
		ins.first_name.should == "raphael"
	end
end