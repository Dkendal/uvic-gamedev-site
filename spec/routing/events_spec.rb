require 'spec_helper'

describe "routes to events controller" do
  it { expect(get: "/my/events/").to route_to "events#index" }

  it { expect(post: "/my/events").to route_to "events#create" }

  it { expect(get: "/my/events/1").to route_to "events#show", id: '1' }

  it { expect(patch: "/my/events/1").to route_to "events#update", id: '1' }

  it { expect(delete: "/my/events/1").to route_to "events#destroy", id: '1' }

  it { expect(get: "/my/events/1/edit").to route_to "events#edit", id: '1' }
end
