# frozen_string_literal: true

require_relative 'spec_helper.rb'

describe 'Test PHQ API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_senstive_data('<PHQ_TOKEN>') { PHQ_TOKEN }
    c.filter_sensitive_data('<PHQ_TOKEN_ESC>') { CGI.escape(PHQ_TOKEN) }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Events information' do
    before do
      @events = FantasticProject::PredictHQAPI.new(PHQ_TOKEN)
                                              .search_events(county: 'TW')
    end

    it 'HAPPY: should recognize owner' do
      _(@project.owner).must_be_kind_of CodePraise::Contributor
    end

    it 'HAPPY: should identify owner' do
      _(@project.owner.username).wont_be_nil
      _(@project.owner.username).must_equal CORRECT['owner']['login']
    end

    it 'HAPPY: should identify contributors' do
      contributors = @project.contributors
      _(contributors.count).must_equal CORRECT['contributors'].count

      usernames = contributors.map(&:username)
      correct_usernames = CORRECT['contributors'].map { |c| c['login'] }
      _(usernames).must_equal correct_usernames
    end
  end
end
