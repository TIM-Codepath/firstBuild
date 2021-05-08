# TIM (Time Matters)

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)
5. [BuildProgress](#BuildProgress)


## Overview
### Description
TIM is the destination for productive life. On TIM, daily personal time spendings are recorded and displayed. Whether you're a student or a workholic, there's always a better way to be more productive.

### App Evaluation
- Category: Lifestyle
- Mobile: This app would be primarily developed for mobile. Functionality wouldn't be limited to mobile devices, however mobile version could potentially have more features.
- Story: Analyzes users' productivity.
- Market: Any individual could choose to use this app.
- Habit: This app can be used as often or unoften as the user wants depending on how accurately they want to measure their productivity.
- Scope: First we would start with user's daily routine by recording and generating reports based on these data.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] User can create an account.
- [X] User logs in to access previous daily report
- [X] User stays logged in across restarts
- [X] User can logout
- [X] Styled Launch Screen and App Icon
- [ ] User can import/create weekly schedule 
- [X] User can select preset (study mode/breaktime/exercise...etc).
- [ ] App generates daily report based on these data. (See [https://cocoapods.org/pods/Charts](https://cocoapods.org/pods/Charts))
- [X] Profile page for user.
- [ ] Settings to configure app options (Accesibility, Notification, General...etc).
- [ ] Calendar feature. (See [https://cocoapods.org/pods/JTAppleCalendar](https://cocoapods.org/pods/JTAppleCalendar))

**Optional Nice-to-have Stories**

- [ ] When user uses cell phone, time is recorded.
- [ ] Intuitive UI/UX to minimize user's interaction with app and still be able to generate accurate analysis on user's daily productivity.
- [ ] Gamified personal statistics on each activity.

### 2. Screen Archetypes

* Login
* Register - User signs up or logs into their account
* Profile Screen - Allows user to upload weekly schedule or fill in information that is needed.
* Daily Report Screen - Allows user to check out daily reports.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Daily reports
* Profile
* Weekly schedule

**Flow Navigation** (Screen to Screen)

* Forced Log-in -> Account creation if no log in is available
* Weekly schedule creation :Text field to be modified.-> Jumps to preset :Text field to be modified.
* Profile -> Text field to be modified.

### 4. UX

**RxSwift**

* *(Optional)* Reactive components & variables can be used to achieve better UX. (Check https://github.com/ReactiveX/RxSwift)

## Wireframes
<img src="https://i.imgur.com/n8FSnIg.gif" width=600>

## Schema 

### Models

#### Model: User
| Property | Type            | Description               |
| -------- | --------        | --------                  |
| author   | Pointer to User | User who is being tracked |
| activity | JSON Object      | Type of activity and time spent |
| username | string      | Username of the use 
| profile_picture | URL      | URL of the user's profile picture 

#### Model: Mode
| Property | Type            | Description               |
| -------- | --------        | --------                  |
| id   | Integer | Unique id |
| name | string      | Name of the mode|

#### Model: Time Logging
| Property | Type            | Description               |
| -------- | --------        | --------                  |
| mode   | Mode | Mode of the logging |
| timer | Integer      | Time spending|

#### Model: Record
| Property | Type            | Description               |
| -------- | --------        | --------                  |
| author   | Pointer to User | User who is being tracked |
| objectId | String      | unique ID for the user log |
| image | file      | image that user uploaded for profile image |
| description | String      | caption by author | 
| startedAt | DateTime      | date when user started stopwatch | 
| endedAt | DateTime      | date when user stopped stopwatch | 



### Networking

#### Sign-In Screen
* GET - Authenticate the user
#### Sign-Up Screen
* POST - Sign up the user
* GET - Authenticate the user
#### Time Log Screen
* POST - Log the type of activity + start/end time
#### User Profile Screen
* READ/GET - Query logged in user object
* UPDATE - Update User Profile Image
#### Calendar Screen
* POST -  Create event in calendar
* GET - Get events to show in calendar
#### Spider Chart Screen
* GET - Get activity times to build the chart
#### Activity Breakdown Screen
* GET - Get activity times to build the activity
#### [Parse] The Local Datastore
* pinInBackground() - Once the local datastore is enabled, you can store an object by pinning it.
#### [Parse] retrieving objects from local datastore
* fromLocalDatastore()/getObjectInBackground() - To get the data for a specific object.

### Snippets
#### GET - Authenticate the user
``` swift
let username = usernameTextField.text!
let password = usernameTextField.text!
PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
    if user != nil {
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    } else {
        print("Error: \(String(describing: error?.localizedDescription))")
    }
}
```
#### POST - Sign up the user
``` swift
let user = PFUser()
user.username = usernameTextField.text
user.password = usernameTextField.text
user.signUpInBackground { (success, error) in
    if success {
        self.performSegue(withIdentifier: "loginSegue", sender: self)
    } else {
        print("Error: \(String(describing: error?.localizedDescription))")
    }
}
```
#### POST - Log the type of activity + start/end time
``` swift
let logging = PFObject(className: "Logging")
let mode = (logging["mode"] as? [PFObject]) ?? []
mode["id"] = 1
mode["name"] = "Study Mode"
logging["timer"] = timer
logging.add(mode, forKey: "mode")
logging.saveInBackground { (success, error) in
    if success {
        print("Logging saved")
    }
}
```
#### PFObject - The Local Datastore
``` swift
let gameScore = PFObject(className: "GameScore")
gameScore["score"] = 1337
gameScore["playerName"] = "AJ"
gameScore["studyMode"] = false
gameScore.pinInBackground()
```
#### PFQuery - The Local Datastore
``` swift
let query = PFQuery(className:"GameScore")
query.from LocalDatastore()
quary.getObjectInBackground(withId:"codePath").continueWith{(task:
BFTask<PFOject>!)->Any? in
if task.error != nil {
return task
}
return task
}
```
## BuildProgress

## Login
<img src="http://g.recordit.co/CmF2A7F8re.gif" width=300>

## User stays logged in across restarts
## User can logout
## Styled launch screen
<img src="http://g.recordit.co/COIHDgDgH2.gif" width=300>

## Radar-graph prototype
<img src="http://g.recordit.co/6k0VH5Hzru.gif" width=300>
<img src="http://g.recordit.co/dVeCVv0Sny.gif" width=300>
## Radar-graph with Parse
<img src="http://g.recordit.co/xYr9QSyxBM.gif" width=300>


## Modified UI
## Edit Profile View Controller
<img src="http://g.recordit.co/4j6cqOp9UR.gif" width=300>

## Modified UI
## User can change profile photo, name and bio
## Time logging feature
<img src="http://g.recordit.co/q9ALh5DCYK.gif" width=300>

## Build Progress Week 12
<img src="http://g.recordit.co/CLnJ6VCuTM.gif" width=300>
