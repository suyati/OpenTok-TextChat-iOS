# OpenTok-TextChat-iOS
A wrapper for OpenTok iOS SDK to easily integrate Text Chat feature into your applications.

#Setup

##Running the Sample App

* Download latest OpenTok iOS SDK from https://tokbox.com/developer/sdks/ios/

* SignUp

* Create an app in https://dashboard.tokbox.com.

* Create a session and token. Also note the API Key.

* Download OpenTok-TextChat-iOS. Add Opentok Framework into your app.

* Open ViewController.m and fill the following details:
```
KAPI_KEY, 
KSESSION_ID, 
KSESSION_TOKEN
```
* Run the application. 

##Integration with existing project 

* Add SYOpenTokClient.h and SYOpenTokClient.m into your project.

* Import .h into your viewController.

* Create an object and intialize it using the following:

```
@interface ViewController ()
{
    SYOpenTokClient *client;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chatArray = [[NSMutableArray alloc] init];
    client = [[SYOpenTokClient alloc] initWithKey:KAPI_KEY
                                        sessionId:KSESSION_ID
                                            token:KSESSION_TOKEN 
                                         delegate:self];

}
```
* To send a message

```
[client sendMessage:message withSignalType:@"chat" toConnection:nil];

params: 

message: The data to send

signalType: The type of the signal 

connection: A destination OTConnection object. (Use this to send a message to specific user).
```
* Implement the delegate method 
```
- (void)chatSession:(OTSession*)session
 receivedSignalType:(NSString*)type
     fromConnection:(OTConnection*)connection
         withString:(NSString*)string
           isAuthor:(BOOL)isAuthor;
  ```
  
* When message is send or received, this delegate method will be called. You can check the author flag to identify the creator of the message. 


#Authors and Contributors

OpenTok-TextChat-iOS is developed by Suyati Technologies. It is written and maintained by their Open Source

Development Team:

* **Rijo George (@rgeorgesuyati)**
* **Krishnanunni P N (@kpnunni)**

#Support or Contact

Have Suggestions? Want to give us something to do? Contact us at : rgeorge@suyati.com
