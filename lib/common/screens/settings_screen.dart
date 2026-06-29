import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/providers/auth_provider.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsSection(
            title: 'Account',
            children: [
              _SettingsTile(icon: Icons.person, title: 'Edit Profile', subtitle: 'Update your personal information', onTap: () {}),
              _SettingsTile(icon: Icons.lock, title: 'Change Password', subtitle: 'Update your password', onTap: () {}),
              _SettingsTile(icon: Icons.security, title: 'Two-Factor Authentication', subtitle: 'Add an extra layer of security', trailing: Switch(value: false, onChanged: (_) {}), onTap: () {}),
              _SettingsTile(icon: Icons.email, title: 'Email Preferences', subtitle: 'Manage notification emails', onTap: () {}),
            ],
          ),
          _SettingsSection(
            title: 'Notifications',
            children: [
              _SettingsTile(icon: Icons.notifications, title: 'Push Notifications', subtitle: 'Enable push notifications', trailing: Switch(value: true, onChanged: (_) {}), onTap: () {}),
              _SettingsTile(icon: Icons.email, title: 'Email Notifications', subtitle: 'Receive email updates', trailing: Switch(value: true, onChanged: (_) {}), onTap: () {}),
              _SettingsTile(icon: Icons.sms, title: 'SMS Alerts', subtitle: 'Critical alerts via SMS', trailing: Switch(value: false, onChanged: (_) {}), onTap: () {}),
              _SettingsTile(icon: Icons.schedule, title: 'Appointment Reminders', subtitle: '24 hours before appointments', trailing: Switch(value: true, onChanged: (_) {}), onTap: () {}),
            ],
          ),
          _SettingsSection(
            title: 'Appearance',
            children: [
              _SettingsTile(icon: Icons.dark_mode, title: 'Dark Mode', subtitle: 'Use dark theme', trailing: Switch(value: false, onChanged: (_) {}), onTap: () {}),
              _SettingsTile(icon: Icons.language, title: 'Language', subtitle: 'English (US)', trailing: const Icon(Icons.chevron_right), onTap: () {}),
              _SettingsTile(icon: Icons.text_fields, title: 'Font Size', subtitle: 'Medium', trailing: const Icon(Icons.chevron_right), onTap: () {}),
            ],
          ),
          _SettingsSection(
            title: 'Privacy & Security',
            children: [
              _SettingsTile(icon: Icons.privacy_tip, title: 'Privacy Policy', subtitle: 'Read our privacy policy', trailing: const Icon(Icons.chevron_right), onTap: () {}),
              _SettingsTile(icon: Icons.description, title: 'Terms of Service', subtitle: 'Read terms and conditions', trailing: const Icon(Icons.chevron_right), onTap: () {}),
              _SettingsTile(icon: Icons.delete_forever, title: 'Delete Account', subtitle: 'Permanently delete your account', textColor: AppTheme.errorColor, onTap: () {}),
            ],
          ),
          _SettingsSection(
            title: 'About',
            children: [
              _SettingsTile(icon: Icons.info, title: 'App Version', subtitle: '1.0.0', onTap: () {}),
              _SettingsTile(icon: Icons.star, title: 'Rate App', subtitle: 'Rate us on the app store', onTap: () {}),
              _SettingsTile(icon: Icons.feedback, title: 'Send Feedback', subtitle: 'Help us improve', onTap: () {}),
              _SettingsTile(icon: Icons.share, title: 'Share App', subtitle: 'Share with friends and family', onTap: () {}),
            ],
          ),
          const SizedBox(height: 24),
          Consumer<AuthProvider>(
            builder: (context, auth, _) => CustomButton(
              text: 'Logout',
              isOutlined: true,
              foregroundColor: AppTheme.errorColor,
              onPressed: () => auth.logout(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
        const SizedBox(height: 8),
        Card(child: Column(children: children)),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Color? textColor;
  final VoidCallback? onTap;

  const _SettingsTile({required this.icon, required this.title, required this.subtitle, this.trailing, this.textColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppTheme.textSecondary),
      title: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}