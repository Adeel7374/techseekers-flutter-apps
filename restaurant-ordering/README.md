# The Northern Fork — restaurant ordering app (SPEC / CONCEPT)

Fictional Manchester restaurant, built as portfolio concept work for the
Flutter client-hunting playbook. This is NOT a real client project and
must be labelled as concept work wherever it is shown.

What it does:
- Menu browsing by category (Starters, Mains, Desserts, Drinks)
- Basket with quantities, pickup/delivery choice, name entry
- Order confirmation screen

How to run (needs the Flutter SDK):
```
cd spec-apps/restaurant-ordering
flutter pub get
flutter run
```

Status (Oct 23, 2026): source complete; Flutter 3.47.7; widget test passes
(menu → basket → checkout → confirmation); web build passes; `flutter analyze`
shows 1 pre-existing warning only (flutter_lints package not in dev_dependencies,
no error in app code). Headless-Chromium screenshot on this VM failed twice
(chrome zygote error, no file produced), so visual check is still unverified —
logic is test-verified instead. Demo: run `flutter run -d chrome` or
`flutter build web` and serve `build/web`.
