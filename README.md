
# PulseNow Flutter Assessment

This repository contains my submission for the **PulseNow Flutter Developer take-home assessment**.

The task focuses on building a Flutter app that displays **crypto market data** using the provided backend API.

---

## What the app does

* Fetches market data from the backend
* Displays a list of crypto symbols with:

  * Current price
  * 24h change and percentage change
* Color coding:

  * Green for positive change
  * Red for negative change
* Handles loading, error (with retry), and empty states
* Supports pull-to-refresh

---

## Tech stack

* Flutter (3.x)
* Provider (state management)
* http (REST API)
* Material 3

---

## Backend setup

```bash
cd backend
npm install
npm start
```

Backend runs on:

```
http://localhost:3000
```

---

## Running the app

```bash
flutter pub get
flutter run
```

For Android emulator, the app uses `10.0.2.2` to access the backend.
This is already configured in the project.

---

## Scope note

The required scope of the assessment focuses on the **Market Data** feature.
Although the backend exposes additional endpoints (analytics, portfolio), this submission intentionally focuses on delivering a clean and complete Market Data implementation.

---

## Author

**Manan Hussain**

