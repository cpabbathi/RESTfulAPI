# CountryHolidays

## Introduction
This app is based on Brian Advent's tutorial, [iOS Swift Tutorial: Use Web APIs and JSON Data with Swift 5](https://youtu.be/tdxKIPpPDAI). This tutorial is taught using UIKit and asynchronous call-backs for API calls. Instead, this app, CountryHolidays is implemented completely using SwiftUI and Combine frameworks.

### Description
App first displays the list of holidays for the user's country of origin and for the current calendar year. On the backend, it calls the [Calendarific APIs](https://calendarific.com/api-documentation) to fetch the list of holidays. Using settings the user can change the country and the calendar year of his/her choice.

### Interface
![Main Screen]()

## Concepts used
1. Publishers and subscribers for decoding JSON data from Calendarific API endpoints
