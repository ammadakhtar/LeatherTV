# LeatherTV

![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)
![Languages](https://img.shields.io/badge/Language-Swift-orange.svg)

A leatherTV inspired app created with custom transitions

## Demo
<img src="https://media.giphy.com/media/04qwsBC0GSqykitH5g/giphy.gif" width="250" height="500" />

## Features

- [x] Image Caching 
- [x] Mocked Data Parsing
- [x] URL / JSON Parameter Encoding
- [x] Network Requests using URLSession (Mocked Only)
- [x] HTTP Response Validation (Network Layer)

### Cool Features

- [x] Custom Transition Animation 😉
- [x] Custom Circular Progress Bar
- [x] AutoLayout without Storyboards/Xib

## Requirements

- iOS 15.0 (Change this to a lower version in project settings if you are not on latest xcode IDE)
- Xcode 13
- Swift 5+

## Clean Architecture using MVVM
in Clean Architecture, we have different layers in the application. The main rule is not to have dependencies from inner layers to outers layers. The arrows pointing from outside to inside is the Dependency rule. There can only be dependencies from outer layer inward
After grouping all layers we have: Presentation, Domain and Data layers.
- #### Domain Layer 
  - Domain Layer (Business logic) is the inner-most part of the onion (without dependencies to other layers, it is totally isolated). It contains Entities(Business Models)
- #### Presentation Layer 
  - Presentation Layer contains UI (UIViewControllers or SwiftUI Views). Views are coordinated by ViewModels (Presenters). Presentation Layer depends only on the Domain Layer
- #### Data Layer
  - Data Layer contains Repository Implementations and one or many Data Sources. Repositories are responsible for coordinating data from different Data Sources. Data Source can be Remote or Local (for example persistent database). Data Layer depends only on the Domain Layer. In this layer, we can also add mapping of Network JSON Data (e.g. Decodable conformance) to Domain Models

- ### Dependency Direction
  - Presentation Layer -> Domain Layer <- Data Repositories Layer
  - Presentation Layer (MVVM) = ViewModels(Presenters) + Views(UI)
  - Domain Layer = Entities
  - Data Repositories Layer = Repositories Implementations + API(Network) + Persistence DB

## Dependencies

- None 😉.

## Installation

- Clone the repo and open the .xcodeProj file
