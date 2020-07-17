//
//  TwitterCache.swift
//  Twitter
//
//  Created by Jonathan Singer on 7/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import Foundation

class TwitterCache {
    static let cache = TwitterCache()
    var tweetArray: [NSDictionary] = []
    var maxTweets: Int = Int.max
    
    private init() {
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": 200]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.maxTweets = self.tweetArray.count
        }, failure: { (e) in
            print(e)
        })
    }
    
    func loadTweets(count:Int, success: @escaping ([NSDictionary]) -> (), failure: @escaping (Error) -> ()){
        if (self.tweetArray.count >= count) {
            success(Array(self.tweetArray[0..<count]))
            return
        }
        if (count > maxTweets) {
            success(Array(self.tweetArray))
            return
        }
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": count]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            if (self.tweetArray.count >= tweets.count){
                success(Array(self.tweetArray[0...count]))
                return
            }
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            success(Array(self.tweetArray[0..<count-1]))
        }, failure: { (e: Error) in
            failure(e)
        })
    }
}
