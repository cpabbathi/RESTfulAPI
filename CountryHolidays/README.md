# CountryHolidays

## Introduction
This app is based on Brian Advent's tutorial, [iOS Swift Tutorial: Use Web APIs and JSON Data with Swift 5](https://youtu.be/tdxKIPpPDAI). This tutorial is taught using UIKit and asynchronous call-backs for API calls. Instead, the CountryHolidays app is implemented completely using SwiftUI and Combine frameworks. It also uses several new SwiftUI 2.0 features

### Description
This app first displays the list of holidays for the user's country and for the current calendar year. On the backend, it calls the [Calendarific APIs](https://calendarific.com/api-documentation) to fetch the list of holidays. Using settings the user can change the country and the calendar year of his/her choice.

## Concepts Highlights
1. Publishers and subscribers for decoding JSON data from Calendarific API endpoints
2. UIKit's view UISearchBar is used in SwiftUI using UIViewRepresentable
3. New SwiftUI concepts like AppStorage, ScrollviewReader, onChange modifier and toolbars
4. Calendarific JSON is not completely Swift compatible when in comes to naming the keys. This app uses coding keys and decoder containers to do the transfomations.

### Interface
#### Main Screen
<img src="Images/Screen%20Shot%202020-11-02%20at%201.07.18%20PM.png" height="300">

#### Holiday Detail Screen
<img src="Images/Screen%20Shot%202020-11-02%20at%201.07.49%20PM.png" height="300">

#### Settings view and Country List
<img src="Images/Screen%20Shot%202020-11-02%20at%201.07.25%20PM.png" height="300"> <img src="Images/Screen%20Shot%202020-11-02%20at%201.07.31%20PM.png" height="300">
