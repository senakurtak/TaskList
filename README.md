
# VeroTaskList

This repository shows task list on BauBuddy API.

## Features of the application
- Resource Request
- Data Storage
- Fetching and listing datas using GET request after login to the site using POST request 
- Searching datas 
- Scanning QR codes
- Refreshing datas
  
## Used technologies
- MVVM Design Pattern
- URLSession
- RealmSwift
- UIKit
- XIB
- Extensions
- AVFoundation
- UITableView
- UISearchBar
- UITabBarController

## Fetching Data
```
 POST https://api.baubuddy.de/index.php/login
  ```
| Parameter | Type     |  Requirement                       |
| :-------- | :------- | :-------------------------------- |
| `oauth`      | `Oauth` | **Required!** |
| `userInfo`      | `UserInfo` |  |
| `permissions`      | `[String]` |  |
| `apiVersion`      | `String` |  |
| `showPasswordPrompt`      | `Bool` |  |

Return values on Oauth to GET Task :     accessToken, expiresIn, tokenType, scope, refreshToken
```
GET https://api.baubuddy.de/dev/index.php/v1/tasks/select?access_token=userAccessTokenString&expires_in=1200&token_type=Bearer&scope=&refresh_token=\(userRefreshTokenString)&
```
