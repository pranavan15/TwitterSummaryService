package org.wso2.ballerina.twitterSummary;

import org.wso2.ballerina.connectors.twitter;
import ballerina.net.http;

const string  consumerKey = "loFfxxVbUtb33RqfiWjtYKJLl";
const string consumerSecret = "RnAQC4iYLIShCRFjRAGsG3CkboGGTlKyW5qXv7RE2Z1NsQYimh";

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
    resource getTweetsByTime (http:Request req, http:Response resp) {
        json reqPayload = req.getJsonPayload();
        accessToken, accessTokenSecret = getAccessTokens(reqPayload);
        var query, _ = (string)reqPayload.query;
        
        twitter:ClientConnector clientConnector =  create twitter:ClientConnector(consumerKey, consumerSecret, accessToken, accessTokenSecret);
        bind clientConnector with twitterConnectorEP;
        
        //var tweetResponse, e = twitterConnectorEP.tweet (query);

        var searchResponse, e = twitterConnectorEP.search (query);
        json responsePayload = searchResponse.getJsonPayload();

        if(e == null) {
            resp.setJsonPayload(responsePayload);
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