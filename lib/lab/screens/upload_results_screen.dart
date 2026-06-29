import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_text_field.dart';

class LabUploadResultsScreen extends StatefulWidget {
  const LabUploadResultsScreen({super.key});

  @override
  State<LabUploadResultsScreen> createState() => _LabUploadResultsScreenState();
}

class _LabUploadResultsScreenState extends State<LabUploadResultsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _testNameController = TextEditingController();
  final _patientController = TextEditingController();
  final _resultsController = TextEditingController();
  final _referenceRangeController = TextEditingController();
  final _notesController = TextEditingController();
  File? _selectedFile;
  bool _isUploading = false;
  String? _abnormalFlag;

  Future<void> _pickFile() async {
    final picker = ImagePicker();
    final picked = await picker.pickMedia();
    if (picked != null) {
      setState(() => _selectedFile = File(picked.path));
    }
  }

  Future<void> _uploadResults() async {
    if (!_formKey.currentState!.validate() || _selectedFile == null) return;
    setState(() => _isUploading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isUploading = false);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Results uploaded successfully')));
      _formKey.currentState!.reset();
      setState(() => _selectedFile = null);
    }
  }

  @override
  void dispose() {
    _testNameController.dispose();
    _patientController.dispose();
    _resultsController.dispose();
    _referenceRangeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Results')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(controller: _patientController, label: 'Patient', hint: 'Select patient', prefixIcon: Icons.person, readOnly: true),
              const SizedBox(height: 16),
              CustomTextField(controller: _testNameController, label: 'Test Name', hint: 'e.g., Complete Blood Count', prefixIcon: Icons.science, validator: (v) => v!.isEmpty ? 'Required' : null),
              const SizedBox(height: 16),
              CustomTextField(controller: _resultsController, label: 'Results', hint: 'Enter test results...', prefixIcon: Icons.description, maxLines: 3, validator: (v) => v!.isEmpty ? 'Required' : null),
              const SizedBox(height: 16),
              CustomTextField(controller: _referenceRangeController, label: 'Reference Range', hint: 'e.g., 4.5-11.0 K/µL', prefixIcon: Icons.straighten),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _abnormalFlag,
                decoration: InputDecoration(
                  labelText: 'Abnormal Flag',
                  prefixIcon: const Icon(Icons.flag),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: ['Normal', 'High', 'Low', 'Critical'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _abnormalFlag = v),
              ),
              const SizedBox(height: 16),
              CustomTextField(controller: _notesController, label: 'Technician Notes', hint: 'Additional notes...', prefixIcon: Icons.note, maxLines: 2),
              const SizedBox(height: 24),
              Text('Attach Report File', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color: AppTheme.primaryColor.withValues(alpha: 0.05),
                  ),
                  child: _selectedFile != null
                      ? Row(children: [Icon(Icons.insert_drive_file, color: AppTheme.primaryColor), const SizedBox(width: 12), Expanded(child: Text(_selectedFile!.path.split('/').last)), IconButton(icon: const Icon(Icons.close), onPressed: () => setState(() => _selectedFile = null))])
                      : Column(children: [Icon(Icons.cloud_upload, size: 48, color: AppTheme.primaryColor), const SizedBox(height: 8), Text('Tap to select file', style: TextStyle(color: AppTheme.primaryColor)), Text('PDF, JPG, PNG up to 10MB', style: Theme.of(context).textTheme.bodySmall)]),
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(text: _isUploading ? 'Uploading...' : 'Upload Results', isLoading: _isUploading, onPressed: _uploadResults),
            ],
          ),
        ),
      ),
    );
  }
}