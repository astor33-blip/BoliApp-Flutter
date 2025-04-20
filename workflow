name: Build Release APK

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build:
    name: Build Android Release APK
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v3

    - name: Set up JDK 11
      uses: actions/setup-java@v3
      with:
        distribution: 'temurin'
        java-version: '11'

    - name: Install Flutter
      uses: subosito/flutter-action@v2
      with:
        channel: stable
        flutter-version: '3.10.6'
        cache: true
    # Con esto evitamos el error "Unable to determine Flutter version..." al no poder resolver solo 'stable' :contentReference[oaicite:0]{index=0}

    - name: Get dependencies
      run: flutter pub get

    - name: Build Release APK
      run: flutter build apk --release

    - name: Upload APK artifact
      uses: actions/upload-artifact@v4
      with:
        name: BoliApp-APK
        path: build/app/outputs/flutter-apk/app-release.apk
    # Ya actualizado a v4 para no chocar con el brown‑out de la v3 :contentReference[oaicite:1]{index=1}
