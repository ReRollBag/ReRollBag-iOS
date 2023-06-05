# ReRollBag-iOS

---

The "ReRollBag" project is an application aimed at promoting sustainable consumption by encouraging the use of reusable bags instead of plastic bags.

## How to build

---

1. pod install
2. add files (GoogleService-Info.plist, secret.swift, config.xcconfig) in ReRollBag Project
  - included api-keys in secret.swift, config.xcconfig


## Features

---

### User
- Custom login and social media account login for "ReRollBag"
- Renting of reusable bags through QR codes attached to the bags
- Returning the rented bags to designated locations using QR codes before the one-week rental period ends
- Promoting the use of reusable bags by allowing users to borrow and return bags without a deposit for rental.
- Users can apply for administrator status through the administrator application menu, receive an authentication number, and enter the number and management area to register as an administrator.

## Technologies Used

---

![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
![Swift](https://img.shields.io/badge/SwiftUI-0052CC?style=for-the-badge&logo=swift&logoColor=white)
![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)

![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Google](https://img.shields.io/badge/google-4285F4?style=for-the-badge&logo=google&logoColor=white)

## Restrictions

---

- To test the project, you must log in with the ID: test@test.com and password: test1234 OR ID: test12@test.com and password: test1234.
- The rental and return location markers cannot be placed worldwide, so they currently exist at "latitude":37.2963, "longitude":127.0471 and "latitude":37.2753, "longitude":127.0413 near Ajou University.
- A QR code is required to proceed with the test, and the code will be included in the presentation video's PPT.
- Currently, the application has not applied localization, so the language is set to Korean only.
- Additionally, not all key values have been uploaded to Github, which may cause problems when building. Therefore, an apk file for testing purposes exists in the submit folder of the Github project. [Firebase App Distribution](https://appdistribution.firebase.google.com/testerapps/1:1037483029667:android:67f9546ca4de9f235abb16/releases/700l1eoomabng?utm_source=firebase-console)

## Application Design

---

- The design work is currently being done through Figma.
- [Figma Link](https://www.figma.com/file/wQyYTV6415CC2EetVwbDKi/Untitled?node-id=0-1)

## Credits

---

The ReRollBag project was developed by a team consisting of a backend developer, Donghwan Lee (Github ID: hwanld) , an Android developer, Heehoon Jeon (Github ID: citytexi), and a designer, Hyeonji Kim, and was created for the 2023 Google Solution Challenge. DuYeong Heo (Github ID: Heodoo) additionally participated as an iOS developer in the challenge team.

## LICENSE

---
ReRollBag is available under the MIT license. See the [LICENSE](https://github.com/ReRollBag/ReRollBag-iOS/blob/main/LICENSE) file for more info.
