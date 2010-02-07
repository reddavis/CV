require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RedDavis" do
  before(:all) do
    @reddavis = RedDavis.new
  end
  
  describe "Blog" do
    it "should return http://redwriteshere" do
      @reddavis.should_receive(:system)
      @reddavis.blog
    end
  end
  
  describe "Location" do
    it "should be a hash" do
      @reddavis.location.should be_a(Hash)
    end
  end
  
  describe "Contact Details" do
    it "should be a hash" do
      @reddavis.contact_details.should be_a(Hash)
    end
  end
  
  describe "Project taken off github" do
    it "should query github and return a hash" do
      Net::HTTP.should_receive(:get).and_return(json)
      @reddavis.projects.should be_a(Hash)
    end
  end
  
  describe "Send a hired email" do
    it "should send the email" do
      Pony.should_receive(:mail)
      @reddavis.hired!(:from => 'supercoolcompany@us.com', :subject => 'we like you!', :body => 'hey')
    end
    
    it "should raise an error" do
      lambda do
        @reddavis.hired!
      end.should raise_error
    end
  end
  
  describe "Share the CV" do
    it "should send to 2 people" do
      Pony.should_receive(:mail).twice
      @reddavis.share_with('me', 'reddavis@gmail.com', 'red@dothegreenthing.com')
    end
  end
  
  describe "to_s" do
    it "should print cv" do
      $stdout = StringIO.new
      @reddavis.to_s
      
      $stdout.string.should match(/Lead Developer$/)
    end
  end
  
  describe "Work experience" do
    it "should return a hash" do
      @reddavis.work_experience.should be_a(Hash)
    end
  end
  
  def json
    %{{"name": "repo_name"}}
  end
end
