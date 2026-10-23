# Glow Studio — salon booking app (SPEC / CONCEPT)

Fictional Manchester salon, built as portfolio concept work for the
Flutter client-hunting playbook. This is NOT a real client project and
must be labelled as concept work wherever it is shown.

What it does:
- Service selection with price and duration (haircut, beard trim, colour, facial, shave, kids cut)
- Day selection (next 7 days) and time-slot selection
- Name entry and booking confirmation screen

How to run (needs the Flutter SDK):
```
cd spec-apps/booking-app
flutter pub get
flutter run
```

Status (Oct 23, 2026): source complete; `flutter analyze` clean; widget test
PASSES (service → day/time → confirm → confirmation, using a tall test
viewport so the ListView confirm button is on-screen); web build passes.
Test lesson: a plain finder for a below-the-fold ListView button sees
0 widgets, and scroll helpers hit duplicate-finder errors — use a tall
test viewport instead.
