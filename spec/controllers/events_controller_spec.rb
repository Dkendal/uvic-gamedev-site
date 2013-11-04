require 'spec_helper'

describe EventsController do
  before do
    Event.any_instance.stub(:fb_create) { true }
    Event.any_instance.stub(:fb_destroy) { true }
    Event.any_instance.stub(:fb_update) { true }
  end

  let(:user) { FactoryGirl.create :user }
  let(:event) { FactoryGirl.create( :event, user: user ) }

  before do
    sign_in user
  end

  describe "GET index" do
    let!(:events) {[event]}

    it "assigns @events" do
      get :index
      expect( assigns(:events) ).to eq events
    end
  end

  describe "GET show" do
    it "assigns @event" do
      get :show, id: event
      expect( assigns(:event) ).to eq event
    end
  end

  describe "GET edit" do
    it "assigns @event" do
      get :show, id: event
      expect( assigns(:event) ).to eq event
    end
  end

  describe "PATCH update" do
  end

  describe "POST create" do
    let(:event) { {
      name: 'an event',
      start_date: '2013/01/01'
    }}

    it "creates and event" do
      expect { post :create, event: event }.
        to change{ Event.count }.by 1
    end
  end

  describe "DELETE destroy " do
    it "destroys the event" do
      expect { delete :destroy, id: event }.
        to change { Event.count }.by 1
    end
  end
end
