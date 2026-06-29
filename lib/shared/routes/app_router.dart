import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../shared/providers/auth_provider.dart';
import '../../auth/screens/login_screen.dart';
import '../../auth/screens/register_screen.dart';
import '../../auth/screens/role_selection_screen.dart';
import '../../doctor/screens/doctor_dashboard_screen.dart';
import '../../doctor/screens/doctor_patients_screen.dart';
import '../../doctor/screens/doctor_appointments_screen.dart';
import '../../doctor/screens/doctor_upload_reports_screen.dart';
import '../../doctor/screens/doctor_view_history_screen.dart';
import '../../patient/screens/patient_profile_screen.dart';
import '../../patient/screens/reports_screen.dart';
import '../../patient/screens/patient_appointments_screen.dart';
import '../../patient/screens/download_reports_screen.dart';
import '../../patient/screens/find_doctors_screen.dart';
import '../../patient/screens/book_appointment_screen.dart';
import '../../shared/widgets/patient_shell.dart';
import '../../lab/screens/test_requests_screen.dart';
import '../../lab/screens/upload_results_screen.dart';
import '../../lab/screens/status_tracking_screen.dart';
import '../../common/screens/notifications_screen.dart';
import '../../common/screens/search_screen.dart';
import '../../common/screens/settings_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/auth/login',
    redirect: (context, state) {
      final auth = context.read<AuthProvider>();
      final isLoggedIn = auth.isAuthenticated;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');

      if (!isLoggedIn && !isAuthRoute) {
        return '/auth/login';
      }
      if (isLoggedIn &&
          isAuthRoute &&
          state.matchedLocation != '/auth/role-selection') {
        if (auth.role == UserRole.patient) return '/patient/profile';
        if (auth.role == UserRole.doctor) return '/doctor/dashboard';
        if (auth.role == UserRole.admin) return '/lab/test-requests';
      }
      return null;
    },
    routes: [
      // Auth Routes
      GoRoute(
        path: '/auth/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/role-selection',
        name: 'role-selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),

      // Doctor Routes
      GoRoute(
        path: '/doctor/dashboard',
        name: 'doctor-dashboard',
        builder: (context, state) => const DoctorDashboardScreen(),
      ),
      GoRoute(
        path: '/doctor/patients',
        name: 'doctor-patients',
        builder: (context, state) => const DoctorPatientsScreen(),
      ),
      GoRoute(
        path: '/doctor/appointments',
        name: 'doctor-appointments',
        builder: (context, state) => const DoctorAppointmentsScreen(),
      ),
      GoRoute(
        path: '/doctor/upload-reports',
        name: 'doctor-upload-reports',
        builder: (context, state) => const DoctorUploadReportsScreen(),
      ),
      GoRoute(
        path: '/doctor/view-history',
        name: 'doctor-view-history',
        builder: (context, state) => const DoctorViewHistoryScreen(),
      ),

      // Patient Routes (with BottomNavBar shell)
      ShellRoute(
        builder: (context, state, child) => PatientShell(child: child),
        routes: [
          GoRoute(
            path: '/patient/profile',
            name: 'patient-profile',
            builder: (context, state) => const PatientProfileScreen(),
          ),
          GoRoute(
            path: '/patient/reports',
            name: 'patient-reports',
            builder: (context, state) => const PatientReportsScreen(),
          ),
          GoRoute(
            path: '/patient/appointments',
            name: 'patient-appointments',
            builder: (context, state) => const PatientAppointmentsScreen(),
          ),
          GoRoute(
            path: '/patient/download-reports',
            name: 'patient-download-reports',
            builder: (context, state) => const DownloadReportsScreen(),
          ),
          GoRoute(
            path: '/patient/find-doctors',
            name: 'patient-find-doctors',
            builder: (context, state) => const FindDoctorsScreen(),
          ),
          GoRoute(
            path: '/patient/book-appointment',
            name: 'patient-book-appointment',
            builder: (context, state) => const BookAppointmentScreen(),
          ),
        ],
      ),

      // Lab Routes
      GoRoute(
        path: '/lab/test-requests',
        name: 'lab-test-requests',
        builder: (context, state) => const LabTestRequestsScreen(),
      ),
      GoRoute(
        path: '/lab/upload-results',
        name: 'lab-upload-results',
        builder: (context, state) => const LabUploadResultsScreen(),
      ),
      GoRoute(
        path: '/lab/status-tracking',
        name: 'lab-status-tracking',
        builder: (context, state) => const LabStatusTrackingScreen(),
      ),

      // Common Routes
      GoRoute(
        path: '/common/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/common/search',
        name: 'search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/common/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
