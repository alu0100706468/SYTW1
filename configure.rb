def my_twitter_client
  Twitter::REST::Client.new do |config|
    config.consumer_key        = '5pyGc0usTdDsynzjqdYmfIyvg'
    config.consumer_secret     = '1bcZbYmPTdjlcvmXWYtixjqyfqBgVmCv52oGIl2Tr6a40RdpZP'
    config.access_token        = '2588217792-WUSIOu1CvHb0ttw0ROLNicgBvSpknJeBfzpIbfG'
    config.access_token_secret = 'vaMwl7n03ztbu4YTMOZgHIM5OWpknoAafopwtu6b0ASJs'
  end
end
