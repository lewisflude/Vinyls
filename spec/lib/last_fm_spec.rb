require './lib/last_fm'
require 'pry'
module RestClient; end
module JSON; end


describe LastFm do
  let(:title) { stub }
  let(:json_response) { stub }
  let(:good_value) do
    {
      'results' => {
        'albummatches' => {
          'album' => [{
            'image' => [{
              '#text' => 'http://google.com/'
              }]
            }]
        }
      }
    }
  end
  let(:bad_value) do 
    {
      'errors' => stub
    }
  end
  before do
    URI.stub(:escape).and_return(title)
    RestClient.stub(:get).and_return(json_response)
    JSON.stub(:parse).and_return(good_value)
  end
  describe "#fetch_album_art" do
    it "takes a title parameter and escapes the title" do
      URI.should_receive(:escape).with(title)
      LastFm.new.fetch_album_art(title)
    end

    context "makes a request to the last.fm api" do
      context "with good parameters" do
        it "makes a successful request" do
          JSON.should_receive(:parse).with(json_response)
          LastFm.new.fetch_album_art(title)
        end
        it "returns the correct URL" do
          LastFm.new.fetch_album_art(title).should == 'http://google.com/'
        end
      end
      context "with bad parameters" do
        before do
          JSON.stub(:parse).and_return(bad_value)
        end
        it "makes a bad request" do
          LastFm.new.fetch_album_art(title).should == nil
        end      
      end
    end
  end
end
