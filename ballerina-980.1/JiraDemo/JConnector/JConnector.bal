import wso2/jira7 as jira;
import ballerina/config;
import ballerina/auth;
import ballerina/http;
import ballerina/log;
import ballerina/io;

endpoint jira:Client jiraEndpoint {
   clientConfig: {
       url: config:getAsString("jira.url"),
       auth:{
           scheme: http:BASIC_AUTH,
           username: config:getAsString("jira.username"),
           password: config:getAsString("jira.password")
       }
   }
};

public function getProjectDetails (string projectKey){
    log:printInfo("Retrieving project information for : "+projectKey);

    jira:JiraConnectorError jError = {};
    jira:Project project = {};

    var result = jiraEndpoint -> getProject(projectKey);

    match result {
        jira:Project p => project = p;
        jira:JiraConnectorError e => jError = e;
    }

    io:println(result);
}