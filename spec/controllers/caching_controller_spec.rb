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
  
  it 'should cache basic code as per normal Rails' do       
    get :basic
    response.body.should == "Hello. This bit's fragment cached. Ciao"
    @store.read('views/test.host/caching/basic').should == "This bit's fragment cached."
  end

  it 'should create a cached view' do       
    lambda { get :basic }.should change(RedOnion::CachedView, :count).by(1)
    RedOnion::CachedView.last.name.should == 'views/test.host/caching/basic'
  end
  
  it 'should save used instance variable dependencies' do
    lambda { get :with_instance_variables }.should change(RedOnion::CachedViewDependency, :count).by(1)
    view_dependency = RedOnion::CachedViewDependency.last
    view_dependency.dependency_type.should == "Sample"
    view_dependency.dependency_id.should_not == 0
  end
  
  it 'should save nested cached views' do
    lambda { get :with_nested_view }.should change(RedOnion::CachedViewDependency, :count).by(1)
    view_dependency = RedOnion::CachedViewDependency.last
    view_dependency.dependency_type.should == "RedOnion::CachedView"
    view_dependency.dependency_id.should_not == 0
  end
end