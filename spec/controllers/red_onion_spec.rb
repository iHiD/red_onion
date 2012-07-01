require 'spec_helper'

describe RedOnion do
  it 'should be a module' do
    RedOnion.should be_a_kind_of(Module)
  end
end

describe CachingController do
  render_views

  before :each do 
    @store = ActiveSupport::Cache::MemoryStore.new
    controller.perform_caching = true
    controller.cache_store = @store
  end
  
  it 'should cache code in a view' do       
    get :basic
    response.body.should == <<-CACHED
Hello
This bit's fragment cached
Ciao
CACHED

    @store.read('views/test.host/caching/basic').should == "This bit's fragment cached"
  end
end