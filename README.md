# tmdb_movies

A new Flutter project.
Stacked version of web.
this codebase created from stacked create app tmdb_movies -t web --platforms ios,android,web

## Setup Project

### Api key store at env

add flutter pub add flutter_dotenv, add .env file then store tmdb api key in there.

## Change Package Name

use this [package](https://pub.dev/packages/change_app_package_name) to change package name. after add plugins just simply use this command.
> **dart run change_app_package_name:main com.new.package.name**

## UI Design

This app UI design is based on this [Figma by Hy Horn](https://www.figma.com/design/OCpGgebMwwuwlJUBkBqri5/Cinemax---Movie-Apps-UI-Kit--Community-?node-id=4-11&p=f&t=iyCwh3OsfjIvV7gG-0) named Cinemax

## Change app icon

change icon easily with this [Package](https://pub.dev/packages/flutter_launcher_icons).
simply run this to generate file then change the data
> **dart run flutter_launcher_icons:generate**

## Golden Tests

Golden tests are already setup for this project. To run the tests and update the golden files, run:

```bash
flutter test --update-goldens
```

The golden test screenshots will be stored under `test/golden/`.
