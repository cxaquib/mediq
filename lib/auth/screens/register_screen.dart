import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../shared/providers/auth_provider.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.local_hospital, size: 80, color: AppTheme.primaryColor),
                  const SizedBox(height: 24),
                  Text('Create Account', style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text('Join MediQ to manage your healthcare', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary), textAlign: TextAlign.center),
                  const SizedBox(height: 40),
                  CustomTextField(controller: _nameController, label: 'Full Name', hint: 'Enter your full name', prefixIcon: Icons.person_outline, validator: (v) => v!.isEmpty ? 'Enter name' : null),
                  const SizedBox(height: 16),
                  CustomTextField(controller: _emailController, label: 'Email', hint: 'Enter your email', prefixIcon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, validator: (v) => v!.isEmpty ? 'Enter email' : null),
                  const SizedBox(height: 16),
                  CustomTextField(controller: _passwordController, label: 'Password', hint: 'Create a password', prefixIcon: Icons.lock_outline, obscureText: _obscurePassword, suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined), onPressed: () => setState(() => _obscurePassword = !_obscurePassword)), validator: (v) => v!.length < 6 ? 'Min 6 chars' : null),
                  const SizedBox(height: 16),
                  CustomTextField(controller: _confirmPasswordController, label: 'Confirm Password', hint: 'Confirm your password', prefixIcon: Icons.lock_outline, obscureText: _obscureConfirmPassword, suffixIcon: IconButton(icon: Icon(_obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined), onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword)), validator: (v) => v != _passwordController.text ? 'Mismatch' : null),
                  const SizedBox(height: 24),
                  Consumer<AuthProvider>(builder: (context, auth, _) => CustomButton(text: 'Create Account', isLoading: auth.isLoading, onPressed: () async { if (_formKey.currentState!.validate()) { final success = await auth.register(_nameController.text.trim(), _emailController.text.trim(), _passwordController.text, UserRole.patient); if (success && context.mounted) context.go('/auth/role-selection'); } })),
                  const SizedBox(height: 24),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Already have an account? '), TextButton(onPressed: () => context.go('/auth/login'), child: Text('Sign In', style: TextStyle(color: AppTheme.primaryColor)))]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}