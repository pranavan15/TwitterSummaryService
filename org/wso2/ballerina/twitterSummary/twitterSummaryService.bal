package org.wso2.ballerina.twitterSummary;

import org.wso2.ballerina.connectors.twitter;
import ballerina.net.http;

const string  consumerKey = "MVwPICv1BF8aUS4HpmDGLuDoo";
const string consumerSecret = "tabhZBl2MdUQOVuwK2v4976e4dmlq59kiHxEnKbTo3HYcFrLlP";

@http:configuration {basePath:"/twitterSummary"}
service<http> twitterSummaryService {
    endpoint<twitter:ClientConnector> twitterConnectorEP {
    }
    
    string accessToken;
    string accessTokenSecret;
    
    @http:resourceConfig {
        methods:["POST"],
        path:"/getTweetsByTime"
    }
    resource getTweetsWithTime (http:Request req, http:Response resp) {
        json reqPayload = req.getJsonPayload();
        accessToken, accessTokenSecret = getAccessTokens(reqPayload);
        var query, _ = (string)reqPayload.query;
        
        twitter:ClientConnector clientConnector =  create twitter:ClientConnector(consumerKey, consumerSecret, accessToken, accessTokenSecret);
        bind clientConnector with twitterConnectorEP;
        
        //var tweetResponse, e = twitterConnectorEP.tweet (query);

        var searchResponse, e = twitterConnectorEP.getUserTimelineStatuses ();
        json responsePayload = searchResponse.getJsonPayload();
        json[] resultsPayload = [];
        if(e == null) {
            int i;
            while(i < lengthof responsePayload) {
                json payloadElement = {};
                payloadElement["Tweet"] = responsePayload[i]["text"];
                payloadElement["Date"] = responsePayload[i]["created_at"];
                resultsPayload[i] = payloadElement;
                i = i + 1;
            }
            resp.setJsonPayload((json)resultsPayload);
        _ = resp.send();
        }
        else {
            resp.setJsonPayload("Something Wrong");
        _ = resp.send();
        }
    }
    
    @http:resourceConfig {
        methods:["POST"],
        path:"/getFollowers"
    }
    resource getFollowers (http:Request req, http:Response resp) {
        json reqPayload = req.getJsonPayload();
        accessToken, accessTokenSecret = getAccessTokens(reqPayload);
        var query, _ = (string)reqPayload.query;
        
        twitter:ClientConnector clientConnector =  create twitter:ClientConnector(consumerKey, consumerSecret, accessToken, accessTokenSecret);
        bind clientConnector with twitterConnectorEP;
        
        //var tweetResponse, e = twitterConnectorEP.tweet (query);

        var searchResponse, e = twitterConnectorEP.getUserFollowers ();
        json responsePayload = searchResponse.getJsonPayload();
        responsePayload = responsePayload["users"];
        json[] resultsPayload = [];
        if(e == null) {
            int i;
            while(i < lengthof responsePayload) {
                json payloadElement = {};
                payloadElement["name"] = responsePayload[i]["name"];
                payloadElement["screen_name"] = responsePayload[i]["screen_name"];
                payloadElement["Following_from"] = responsePayload[i]["created_at"];
                resultsPayload[i] = payloadElement;
                i = i + 1;
            }
            resp.setJsonPayload((json)resultsPayload);
        _ = resp.send();
        }
        else {
            resp.setJsonPayload("Something Wrong");
        _ = resp.send();
        }
    }
    
    @http:resourceConfig {
        methods:["POST"],
        path:"/getFollowingFriends"
    }
    resource getFollowingFriends (http:Request req, http:Response resp) {
        json reqPayload = req.getJsonPayload();
        accessToken, accessTokenSecret = getAccessTokens(reqPayload);
        var query, _ = (string)reqPayload.query;
        
        twitter:ClientConnector clientConnector =  create twitter:ClientConnector(consumerKey, consumerSecret, accessToken, accessTokenSecret);
        bind clientConnector with twitterConnectorEP;
        
        //var tweetResponse, e = twitterConnectorEP.tweet (query);

        var searchResponse, e = twitterConnectorEP.getUserFollowingFriends ();
        json responsePayload = searchResponse.getJsonPayload();
        responsePayload = responsePayload["users"];
        json[] resultsPayload = [];
        if(e == null) {
            int i;
            while(i < lengthof responsePayload) {
                json payloadElement = {};
                payloadElement["name"] = responsePayload[i]["name"];
                payloadElement["screen_name"] = responsePayload[i]["screen_name"];
                payloadElement["Following_from"] = responsePayload[i]["created_at"];
                resultsPayload[i] = payloadElement;
                i = i + 1;
            }
            resp.setJsonPayload((json)resultsPayload);
        _ = resp.send();
        }
        else {
            resp.setJsonPayload("Something Wrong");
        _ = resp.send();
        }
    }
}

function getAccessTokens(json reqPayload) (string accessToken, string accessTokenSecret) {
    accessToken, _ = (string)reqPayload.accessToken;
    accessTokenSecret, _ = (string)reqPayload.accessTokenSecret;
    return;
}