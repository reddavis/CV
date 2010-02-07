require 'pony'
require 'net/http'
require 'json'

class RedDavis
  
  # Returns a hash containg info about all my current OS projects on Github
  def projects
    request = Net::HTTP.get(URI.parse(github_profile_url))
    JSON.parse(request)
  end
  
  def location
    {
      :country => 'England',
      :city => 'Bath',
      :google_map => "http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=Bath,+Avon,+United+Kingdom&sll=37.0625,-95.677068&sspn=55.981213,108.544922&ie=UTF8&hq=&hnear=Bath,+Avon,+United+Kingdom&z=13"
    }
  end
  
  # Opens a browser window and sends you to my blog (Not tested on Windows)
  def blog
    system("open #{blog_url}")
  end
  
  def interested_in
    [
      'Machine Learning',
      'Data',
      'Ruby',
      'Rails',
      'Fun things'
    ]
  end
  
  def work_experience
    {
      :green_thing => {
                        :url => 'http://dothegreenthing.com',
                        :position => 'Lead Developer',
                        :started => Time.local(2008, 'apr', 1),
                        :finished => nil
                      }
    }
  end
  
  # Print out all basic information
  def print
    text = File.expand_path(File.dirname(__FILE__) + '/text/cv.txt')
    File.readlines(text).each do |line|
      puts line
    end
  end
  
  # Hire me!
  # * :from => Who you are
  # * :body => A little message
  # * :subject => Subject of the email
  def hired!(options={})    
    raise "You need to specify from, subject and body" unless options.key?(:from) || options.key?(:body) || options.key?(:subject)
    Pony.mail({:to => 'reddavis@gmail.com'}.merge(options))
  end
  
  # My contact details
  def contact_details
    {
      :email => 'reddavis@gmail.com',
      :phone => '07515353733'
    }
  end
  
  # Shared me CV with fellow co-workers. Sends them a URL to download this CV
  def share_with(from, *emails)
    emails.each do |email|
      Pony.mail(:to => email, 
                :from => from, 
                :subject => 'Hey what do you think of this guy...', 
                :body => github_cv_url)
    end
  end

  private
  
  def github_profile_url
    'http://github.com/api/v2/json/repos/show/reddavis'
  end
  
  def github_cv_url
    'http://github.com/reddavis/CV'
  end
  
  def blog_url
    'http://redwriteshere.com'
  end
  
end