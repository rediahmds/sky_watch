# SkyWatch: Weather Information at Hands

A Flutter-based app that provides weather information for multiple locations and offers recommendations based on the current weather.

## Requirements

- [x] Implement at least a `StatelessWidget` such as `Row` or `Column`.
- [x] Implement at least a `StatefulWidget` to display app status or takes input from user.
- [ ] Contains at least **two** pages and implement `Navigation`.
- [ ] No UI overflow. In addition, responsive in both mobile and web is a **plus**.

## About

- Design inspired by [Desire Creative Agency for Desire Creative - Mobile | Weather App - Dribble](https://dribbble.com/shots/20675054-Mobile-Weather-app?utm_source=Clipboard_Shot&utm_campaign=desire-creative_agency&utm_content=Mobile%20%7C%20Weather%20app&utm_medium=Social_Share&utm_source=Clipboard_Shot&utm_campaign=desire-creative_agency&utm_content=Mobile%20%7C%20Weather%20app&utm_medium=Social_Share) - _Thank you so much!_
- Third party packages used in this app:
    - [dio v5.7.0](https://pub.dev/packages/dio)
    - [geolocator v13.0.1](https://pub.dev/packages/geolocator)
    - [intl v.0.19.0](https://pub.dev/packages/intl)
    - [flutter_dotenv v5.1.0](https://pub.dev/packages/flutter_dotenv)

## Todo

- [x] Fetch current weather info and icon
- [ ] Filter to 5 days in home and show details on next page
- [ ] Remove cryptic error message in homepage.
- Settings page include custom user api key and current location