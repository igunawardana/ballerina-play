import ballerina/io;
import ballerina/test;

# Before Suite Function

@test:BeforeSuite
function beforeSuiteServiceFunc () {
    io:println("I'm the before suite service function!");
}

# Test function

@test:Config
function testServiceFunction () {
    io:println("Do your service Tests!");
    string response = callService();
    io:println("Response Recieved: "+response);
    test:assertTrue( response.equalsIgnoreCase("Hello Ballerina!\n"), msg = "Failed!");
}

# After Suite Function

@test:AfterSuite
function afterSuiteServiceFunc () {
    io:println("I'm the after suite service function!");
}

function callService() returns (string) {

    endpoint http:Client helloService {
        url: "http://localhost:9090/"
    };

    http:Response success;
    error err;

    var resp = helloService -> get("/hello/sayHello");
    match resp{
        http:Response r => success = r;
        error e => err = e;
    }

    io:println(resp);

    if (err != null) {
        var x = success.getTextPayload(); 
        io:print("Successfully called the endpoint and Recieved Text Payload: ");
        io:println(x);
        return check x;
    } else {
        io:println("Couldn't call to the endpoint");
        io:println(err);
        return err.message;
    }
}
