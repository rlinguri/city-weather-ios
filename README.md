# city-weather-ios #

_A weather-based app where users can look up the weather for a city._

| <!--   --> | <!--                                  --> |
|------------|-------------------------------------------|
| Identifier | com.linguri.CityWeather                   |
| Author     | Roderic Linguri <938388@cognozant.com>    |
| Copyright  | © 2023 Roderic Linguri                    |
| License    | [MIT](../../blob/develop/LICENSE)         |
| Version    | 0.1.4 (Pre-Release)                       |
| Requires   | Xcode 14, iOS 15.6, Swift 5.0             |

### Getting Started ###

1. Clone this repository with `git clone git@github.com:rlinguri/city-weather-ios.git`

2. API Key

   - In order for the app to connect to the OpenWeather API, you will need to add the API key to your `.bash_profile`. After signing up and signing in, you should find it at [home.openweathermap.org/api_keys](https://home.openweathermap.org/api_keys).

   - Then add the following line to the file:

   `export OPENWEATHERMAP_API_KEY=<The key you copied in the previous step>`

   - Then when you build the app, script build phases should replace the placeholder with the actual key before compiling and restore the placeholder after completion.

   - To verify, select the `Environment.swift` file in the navigator and build the project. You should momentarily see the placeholder get replaced with the actual API key, and then get restored once the build is complete.
