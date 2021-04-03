# firstBuildOriginal App Design Project - README
===

# TIM (Time Matters)

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview
### Description
- **TIM is the destination for productive life. On TIM, daily personal time spendings are recorded and displayed. Whether you're a student or a workholic, there's always a better way to be more productive.**

### App Evaluation
- **Category: Lifestyle**
- **Mobile: This app would be primarily developed for mobile. Functionality wouldn't be limited to mobile devices, however mobile version could potentially have more features.**
- **Story: Analyzes users' productivity.**
- **Market: Any individual could choose to use this app.**
- **Habit: This app can be used as often or unoften as the user wants depending on how accurately they want to measure their productivity.**
- **Scope: First we would start with user's daily routine by recording and generating reports based on these data.**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can sign up to create an account
* User logs in to access previous daily report
* User can import/create weekly schedule 
* User can select preset (study mode/breaktime/exercise...etc).
* App generates daily report based on these data.
* Profile page for user.
* Settings to configure app options (Accesibility, Notification, General...etc).
* Calendar feature. (See [https://cocoapods.org/pods/JTAppleCalendar](https://cocoapods.org/pods/JTAppleCalendar))

**Optional Nice-to-have Stories**

* When user uses cell phone, time is recorded.
* Intuitive UI/UX to minimize user's interaction with app and still be able to generate accurate analysis on user's daily productivity.
* Gamified personal statistics on each activity.

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
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
