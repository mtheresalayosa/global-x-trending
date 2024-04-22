class TrendsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'json'
  @@redis = Redis.new
  @@sample_tweets = {"trends"=>{"0"=>{"name"=>"Ukraine", "query"=>"Ukraine", "url"=>"search?q=%22Ukraine%22", "volume"=>1819999, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "1"=>{"name"=>"America", "query"=>"America", "url"=>"search?q=%22America%22", "volume"=>746000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "2"=>{"name"=>"América", "query"=>"Am%C3%A9rica", "url"=>"search?q=%22Am%C3%A9rica%22", "volume"=>730000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "3"=>{"name"=>"Game 1", "query"=>"Game+1", "url"=>"search?q=%22Game+1%22", "volume"=>630000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "4"=>{"name"=>"Ryan", "query"=>"Ryan", "url"=>"search?q=%22Ryan%22", "volume"=>608000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "5"=>{"name"=>"سيتي", "query"=>"%D8%B3%D9%8A%D8%AA%D9%8A", "url"=>"search?q=%22%D8%B3%D9%8A%D8%AA%D9%8A%22", "volume"=>574000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "6"=>{"name"=>"Biden", "query"=>"Biden", "url"=>"search?q=%22Biden%22", "volume"=>541000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "7"=>{"name"=>"#ZNNBeCloser2ndFansign", "query"=>"%23ZNNBeCloser2ndFansign", "url"=>"search?q=%22%23ZNNBeCloser2ndFansign%22", "volume"=>528000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "8"=>{"name"=>"Haney", "query"=>"Haney", "url"=>"search?q=%22Haney%22", "volume"=>504000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "9"=>{"name"=>"#BEAUTILOXxEVEANDBOY", "query"=>"%23BEAUTILOXxEVEANDBOY", "url"=>"search?q=%22%23BEAUTILOXxEVEANDBOY%22", "volume"=>430000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "10"=>{"name"=>"CHARLOTTE PST BEAUTILOX", "query"=>"CHARLOTTE+PST+BEAUTILOX", "url"=>"search?q=%22CHARLOTTE+PST+BEAUTILOX%22", "volume"=>421000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "11"=>{"name"=>"#ขวัญฤทัยEP6", "query"=>"%23%E0%B8%82%E0%B8%A7%E0%B8%B1%E0%B8%8D%E0%B8%A4%E0%B8%97%E0%B8%B1%E0%B8%A2EP6", "url"=>"search?q=%22%23%E0%B8%82%E0%B8%A7%E0%B8%B1%E0%B8%8D%E0%B8%A4%E0%B8%97%E0%B8%B1%E0%B8%A2EP6%22", "volume"=>394000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "12"=>{"name"=>"Copacabana", "query"=>"Copacabana", "url"=>"search?q=%22Copacabana%22", "volume"=>331000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "13"=>{"name"=>"Palestinian", "query"=>"Palestinian", "url"=>"search?q=%22Palestinian%22", "volume"=>323000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "14"=>{"name"=>"Madrid", "query"=>"Madrid", "url"=>"search?q=%22Madrid%22", "volume"=>313000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "15"=>{"name"=>"#JeffSaturSpaceShuttleNo8BKK", "query"=>"%23JeffSaturSpaceShuttleNo8BKK", "url"=>"search?q=%22%23JeffSaturSpaceShuttleNo8BKK%22", "volume"=>283000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "16"=>{"name"=>"Coventry", "query"=>"Coventry", "url"=>"search?q=%22Coventry%22", "volume"=>267000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "17"=>{"name"=>"BTS PAVED THE WAY", "query"=>"BTS+PAVED+THE+WAY", "url"=>"search?q=%22BTS+PAVED+THE+WAY%22", "volume"=>259000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "18"=>{"name"=>"#HaneyGarcia", "query"=>"%23HaneyGarcia", "url"=>"search?q=%22%23HaneyGarcia%22", "volume"=>215000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "19"=>{"name"=>"#QueenOfTearsEp14", "query"=>"%23QueenOfTearsEp14", "url"=>"search?q=%22%23QueenOfTearsEp14%22", "volume"=>203000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "20"=>{"name"=>"MAGA", "query"=>"MAGA", "url"=>"search?q=%22MAGA%22", "volume"=>198000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "21"=>{"name"=>"Maná", "query"=>"Man%C3%A1", "url"=>"search?q=%22Man%C3%A1%22", "volume"=>197000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "22"=>{"name"=>"LINK IN BIO", "query"=>"LINK+IN+BIO", "url"=>"search?q=%22LINK+IN+BIO%22", "volume"=>180000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "23"=>{"name"=>"Link in Bio", "query"=>"Link+in+Bio", "url"=>"search?q=%22Link+in+Bio%22", "volume"=>179000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "24"=>{"name"=>"Chelsea", "query"=>"Chelsea", "url"=>"search?q=%22Chelsea%22", "volume"=>169000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "25"=>{"name"=>"River", "query"=>"River", "url"=>"search?q=%22River%22", "volume"=>160000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "26"=>{"name"=>"SAROCHA REBECCA WDFM ON STAGE", "query"=>"SAROCHA+REBECCA+WDFM+ON+STAGE", "url"=>"search?q=%22SAROCHA+REBECCA+WDFM+ON+STAGE%22", "volume"=>159000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "27"=>{"name"=>"#ChineseGP", "query"=>"%23ChineseGP", "url"=>"search?q=%22%23ChineseGP%22", "volume"=>156000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "28"=>{"name"=>"Pakistan", "query"=>"Pakistan", "url"=>"search?q=%22Pakistan%22", "volume"=>153000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "29"=>{"name"=>"Happy 420", "query"=>"Happy+420", "url"=>"search?q=%22Happy+420%22", "volume"=>147000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "30"=>{"name"=>"#TodosALaCalle21A", "query"=>"%23TodosALaCalle21A", "url"=>"search?q=%22%23TodosALaCalle21A%22", "volume"=>133000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "31"=>{"name"=>"Union", "query"=>"Union", "url"=>"search?q=%22Union%22", "volume"=>132000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "32"=>{"name"=>"DAOUOFFROAD 1st FANCON", "query"=>"DAOUOFFROAD+1st+FANCON", "url"=>"search?q=%22DAOUOFFROAD+1st+FANCON%22", "volume"=>131000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "33"=>{"name"=>"#ووٹ_عمران_خان_کا", "query"=>"%23%D9%88%D9%88%D9%B9_%D8%B9%D9%85%D8%B1%D8%A7%D9%86_%D8%AE%D8%A7%D9%86_%DA%A9%D8%A7", "url"=>"search?q=%22%23%D9%88%D9%88%D9%B9_%D8%B9%D9%85%D8%B1%D8%A7%D9%86_%D8%AE%D8%A7%D9%86_%DA%A9%D8%A7%22", "volume"=>130000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "34"=>{"name"=>"Manchester United", "query"=>"Manchester+United", "url"=>"search?q=%22Manchester+United%22", "volume"=>127000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "35"=>{"name"=>"Edmundo", "query"=>"Edmundo", "url"=>"search?q=%22Edmundo%22", "volume"=>125000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "36"=>{"name"=>"Senate", "query"=>"Senate", "url"=>"search?q=%22Senate%22", "volume"=>120000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "37"=>{"name"=>"LILIES FOR LISA", "query"=>"LILIES+FOR+LISA", "url"=>"search?q=%22LILIES+FOR+LISA%22", "volume"=>118000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "38"=>{"name"=>"Cuba", "query"=>"Cuba", "url"=>"search?q=%22Cuba%22", "volume"=>117000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "39"=>{"name"=>"Jordan", "query"=>"Jordan", "url"=>"search?q=%22Jordan%22", "volume"=>112000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "40"=>{"name"=>"علي محمد علي", "query"=>"%D8%B9%D9%84%D9%8A+%D9%85%D8%AD%D9%85%D8%AF+%D8%B9%D9%84%D9%8A", "url"=>"search?q=%22%D8%B9%D9%84%D9%8A+%D9%85%D8%AD%D9%85%D8%AF+%D8%B9%D9%84%D9%8A%22", "volume"=>109000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "41"=>{"name"=>"Heat", "query"=>"Heat", "url"=>"search?q=%22Heat%22", "volume"=>107000, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "42"=>{"name"=>"Nico", "query"=>"Nico", "url"=>"search?q=%22Nico%22", "volume"=>99199, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "43"=>{"name"=>"Ten Hag", "query"=>"Ten+Hag", "url"=>"search?q=%22Ten+Hag%22", "volume"=>97800, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "44"=>{"name"=>"FA Cup", "query"=>"FA+Cup", "url"=>"search?q=%22FA+Cup%22", "volume"=>96800, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "45"=>{"name"=>"Barca", "query"=>"Barca", "url"=>"search?q=%22Barca%22", "volume"=>96400, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "46"=>{"name"=>"Barça", "query"=>"Bar%C3%A7a", "url"=>"search?q=%22Bar%C3%A7a%22", "volume"=>95400, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "47"=>{"name"=>"SB19 XIAOMI WHAT YOU GOT", "query"=>"SB19+XIAOMI+WHAT+YOU+GOT", "url"=>"search?q=%22SB19+XIAOMI+WHAT+YOU+GOT%22", "volume"=>92400, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "48"=>{"name"=>"hyunwoo", "query"=>"hyunwoo", "url"=>"search?q=%22hyunwoo%22", "volume"=>88600, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}, "49"=>{"name"=>"#FACup", "query"=>"%23FACup", "url"=>"search?q=%22%23FACup%22", "volume"=>88400, "volumeShort"=>"", "domainContext"=>"", "groupedTrends"=>[]}}, "location"=>{"name"=>"Worldwide", "woeid"=>1}, "created"=>{"created_at"=>1713729671, "created_at_v1"=>"2024-04-21T20:01:11Z"}}

  # Direct call to Twitter API for search trends by location
  def twitter_search tw_woeid
    url = URI("https://twitter-trends5.p.rapidapi.com/twitter/request.php")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/x-www-form-urlencoded'
    request["X-RapidAPI-Key"] = 'a22a86a9cfmsh155e30bfc3bc635p10f395jsn251803e0c2ff'
    request["X-RapidAPI-Host"] = 'twitter-trends5.p.rapidapi.com'
    request.body = "woeid=#{tw_woeid}"

    response = http.request(request)
    data = response.read_body
  end

  # Get global trends data
  def global_trends
    # tweets = JSON.parse(twitter_search 1)
    tweets = @@sample_tweets

    data = []
    tweets["trends"].each do |key, tweet|
      tweet_info = { "name"=>tweet["name"], "location"=>"Worldwide", "tweet_volumes" => [{"volume"=>tweet["volume"],"created_at"=> Time.at(tweets["created"]["created_at"])}]  }
      data << tweet_info
      if @@redis.exists?(tweet["name"]) == false
        # save data to redis
        @@redis.set(tweet["name"], tweet_info)
      else
        # if data exists in json, add updates of tweet volume with datestamp
        tdata = @@redis.get(tweet["name"])
        puts "tdata exists: #{tdata}"
        tvolumes = tdata["tweet_volumes"]
        tvolumes << {"volume"=>tweet["volume"],"created_at"=> Time.at(tweets["created"]["created_at"])}
        tdata["tweet_volumes"] = tvolumes
        @@redis.set(tweet["name"], tdata)
      end
    end
    render json: data, status: 200
  end

  # Search route - trends by location
  def search_location
    woeid = params[:src_woeid]
    tweets = JSON.parse(twitter_search woeid)
    data = []
    tweets["trends"].each do |key, tweet|
      tweet_info = { "name"=>tweet["name"], "location"=>"Worldwide", "tweet_volumes" => [{"volume"=>tweet["volume"],"created_at"=> Time.at(tweets["created"]["created_at"])}]  }
      data << tweet_info
    end
    render json: data, status: 200
  end

  # Route to set real-time updates of trends call
  def trends_updates
    # set broadcast update to concurrent users
    #turbo::streams.broadcast
  end
end
