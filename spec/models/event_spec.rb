require 'spec_helper'

describe Event do
  describe ".ends" do
    let(:event) { FactoryGirl.build :event,
      end_date: nil, end_time: nil }

    it "is optional" do
      expect( event ).to be_valid
    end
  end

  describe ".starts" do
    let(:event) { FactoryGirl.build :event }
    before { event.stub(:starts) { Time.now } }
    before { event.stub(:ends) { 1.minute.ago } }

    it "cannot be after .ends" do
      expect( event ).to_not be_valid
    end
  end

  describe "@end_time" do
    it "is valid if @end_date is present" do
      expect(FactoryGirl.build :event,
             end_date: "2099/12/01",
             end_time: "23:59").to be_valid
    end
    it "is not valid if @end_date is missing" do
      expect(FactoryGirl.build :event,
             end_date: nil,
             end_time: "23:59").to_not be_valid
    end
  end

  describe "@start_time" do
    it "is expected be in the format 'hh:mm'" do
      expect(FactoryGirl.build :event,
             start_time: "13:00" ).to be_valid
    end
  end

  describe "@start_date" do
    it "is expected to be in the format 'yyyy/mm/dd'" do
      expect(FactoryGirl.build :event,
             start_date: "2013/12/31" ).to be_valid
    end

    it "is required" do
      expect(FactoryGirl.build :event,
             start_date: nil ).to_not be_valid
    end
  end

  describe "@name" do
    it "is required" do
      expect(FactoryGirl.build :event,
             name: '' ).to_not be_valid
    end
  end
end
