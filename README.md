# NestDomainDemo
Tech test for DomainIOSDev

## Build and Runtime Requirements
Xcode 8.0 or later iOS 9.0 or later OS X v10.12 or later

## Configuring the Project
Please clone the project in your local machine and open with the latest version of Xcode. Build and run the project after selecting a device from the device inspector.

##  About NestDemoDomain
Tech test for Domain, written using Swift 3.0. The app accesses domain api to fetch Properties and display it to the user in realtime. The app refreshes latest poperties as soon as the user launches the app or during switch between the menu buttons. 

## Unit Tests
Unit tests are written to test asynchronous code (creating the request to be sent to the apimanager) and Helper code which processed date data. Mocking the response from the api manager and processing json data.
### UITests : 
Basic UI tests to check the presence of MenuBar buttons on the view
### Performance test : 
To test processing time required to process dictionary of data fetched from Api.
### Code Coverage :
Approx 75%

### Steps to Execute tests:
Please follow instructions inside the code comments and inside test targets. Please make sure that the code module to be tested is included in the test target memberships.

Repo Owner
Navdeep Singh
