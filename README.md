# MediQ - Healthcare Management App

A Flutter healthcare management application with role-based access for Patients, Doctors, and Lab Technicians.

## Features

### Authentication
- Login / Register
- Role Selection (Patient, Doctor, Lab Technician)

### Doctor Module
- Dashboard with statistics
- Patient management
- Appointment scheduling
- Upload medical reports
- View patient history

### Patient Module
- Profile management
- View/download medical reports
- Appointment booking & history
- Download reports

### Lab Technician Module
- Test request management
- Upload test results
- Status tracking

### Common Features
- Notifications
- Search
- Settings

## Project Structure

```
lib/
├── main.dart
├── auth/
│   └── screens/
│       ├── login_screen.dart
│       ├── register_screen.dart
│       └── role_selection_screen.dart
├── doctor/
│   └── screens/
│       ├── doctor_dashboard_screen.dart
│       ├── doctor_patients_screen.dart
│       ├── doctor_appointments_screen.dart
│       ├── doctor_upload_reports_screen.dart
│       └── doctor_view_history_screen.dart
├── patient/
│   └── screens/
│       ├── patient_profile_screen.dart
│       ├── reports_screen.dart
│       ├── patient_appointments_screen.dart
│       └── download_reports_screen.dart
├── lab/
│   └── screens/
│       ├── test_requests_screen.dart
│       ├── upload_results_screen.dart
│       └── status_tracking_screen.dart
├── common/
│   └── screens/
│       ├── notifications_screen.dart
│       ├── search_screen.dart
│       └── settings_screen.dart
└── shared/
    ├── providers/
    │   ├── auth_provider.dart
    │   └── user_provider.dart
    ├── routes/
    │   └── app_router.dart
    ├── theme/
    │   └── app_theme.dart
    ├── services/
    │   └── storage_service.dart
    └── widgets/
        ├── custom_button.dart
        ├── custom_text_field.dart
        └── scaffold_with_navbar.dart
```

## Getting Started

1. Install Flutter SDK (3.2.0+)
2. Run `flutter pub get`
3. Run `flutter run`

## Dependencies

- `go_router` - Navigation
- `provider` - State management
- `flutter_secure_storage` - Secure token storage
- `http` - API calls
- `image_picker` - File/image selection
- `file_picker` - Document selection
- `intl` - Date formatting