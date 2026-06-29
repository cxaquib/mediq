import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';

class DoctorUploadReportsScreen extends StatefulWidget {
  const DoctorUploadReportsScreen({super.key});

  @override
  State<DoctorUploadReportsScreen> createState() => _DoctorUploadReportsScreenState();
}

class _DoctorUploadReportsScreenState extends State<DoctorUploadReportsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _patientController = TextEditingController();
  final _reportTypeController = TextEditingController();
  final _notesController = TextEditingController();
  File? _selectedFile;
  bool _isUploading = false;

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    final picked = await picker.pickMedia();
    if (picked != null) {
      setState(() => _selectedFile = File(picked.path));
    }
  }

  Future<void> _uploadReport() async {
    if (!_formKey.currentState!.validate() || _selectedFile == null) return;
    setState(() => _isUploading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isUploading = false);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Report uploaded successfully')));
      _formKey.currentState!.reset();
      setState(() => _selectedFile = null);
    }
  }

  @override
  void dispose() {
    _patientController.dispose();
    _reportTypeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Reports')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(controller: _patientController, label: 'Patient Name', hint: 'Select patient', prefixIcon: Icons.person, readOnly: true, onTap: () {}),
              const SizedBox(height: 16),
              CustomTextField(controller: _reportTypeController, label: 'Report Type', hint: 'e.g., Blood Test, X-Ray, MRI', prefixIcon: Icons.description, validator: (v) => v!.isEmpty ? 'Required' : null),
              const SizedBox(height: 16),
              CustomTextField(controller: _notesController, label: 'Notes', hint: 'Additional notes...', prefixIcon: Icons.note, maxLines: 3),
              const SizedBox(height: 24),
              Text('Attach File', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryColor, style: BorderStyle.solid, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color: AppTheme.primaryColor.withValues(alpha: 0.05),
                  ),
                  child: _selectedFile != null
                      ? Row(
                          children: [
                            Icon(Icons.insert_drive_file, color: AppTheme.primaryColor),
                            const SizedBox(width: 12),
                            Expanded(child: Text(_selectedFile!.path.split('/').last)),
                            IconButton(icon: const Icon(Icons.close), onPressed: () => setState(() => _selectedFile = null)),
                          ],
                        )
                      : Column(
                          children: [
                            Icon(Icons.cloud_upload, size: 48, color: AppTheme.primaryColor),
                            const SizedBox(height: 8),
                            Text('Tap to select file', style: TextStyle(color: AppTheme.primaryColor)),
                            Text('PDF, JPG, PNG up to 10MB', style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(text: _isUploading ? 'Uploading...' : 'Upload Report', isLoading: _isUploading, onPressed: _uploadReport),
            ],
          ),
        ),
      ),
    );
  }
}