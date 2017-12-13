package org.wso2.ballerina.twitterSummary.util;

function getKeysAndAccessTokens(json reqPayload) (string consumerKey, string consumerSecret, string accessToken, string accessTokenSecret) {
    consumerKey, _ = (string)reqPayload.consumerKey;
    consumerSecret, _ = (string)reqPayload.consumerSecret;
    accessToken, _ = (string)reqPayload.accessToken;
    accessTokenSecret, _ = (string)reqPayload.accessTokenSecret;
    return;
}
