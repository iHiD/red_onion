module RedOnion
  describe CachedView do
    it "adds a dependency" do
      cached_view = RedOnion::CachedView.create!(name: "Test")
      sample = Sample.create!
      
      lambda {
        cached_view.add_dependency(sample)
      }.should change(RedOnion::CachedViewDependency, :count).by(1)
      
      dependency = RedOnion::CachedViewDependency.last
      dependency.dependency_type.should == "Sample"
      dependency.dependency_id.should == sample.id
    end
  end
end