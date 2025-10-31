import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/api_service.dart';
import '../models/api_models.dart';
import 'error_display.dart';
import 'loading_indicator.dart';
import 'media_result_display.dart';

class ApiTestCard extends StatefulWidget {
  final String modelName;
  final String description;
  final String endpoint;
  final List<ApiParameter> parameters;
  final String? samplePrompt;
  final bool requiresFileUpload;

  const ApiTestCard({
    super.key,
    required this.modelName,
    required this.description,
    required this.endpoint,
    required this.parameters,
    this.samplePrompt,
    this.requiresFileUpload = false,
  });

  @override
  State<ApiTestCard> createState() => _ApiTestCardState();
}

class _ApiTestCardState extends State<ApiTestCard> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, dynamic> _values = {};
  String? _selectedFilePath;
  String? _uploadedFileUrl;
  bool _isLoading = false;
  ApiResponse? _response;

  @override
  void initState() {
    super.initState();
    for (var param in widget.parameters) {
      if (param.type == 'text') {
        _controllers[param.name] = TextEditingController(
          text: param.name == 'prompt' ? widget.samplePrompt : param.defaultValue,
        );
      } else {
        _values[param.name] = param.defaultValue;
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'mp4', 'mov'],
    );

    if (result != null) {
      setState(() {
        _selectedFilePath = result.files.single.path;
      });

      // Upload file
      setState(() => _isLoading = true);
      final uploadResponse = await ApiService.uploadFile(_selectedFilePath!);
      setState(() => _isLoading = false);

      if (uploadResponse.success) {
        setState(() {
          _uploadedFileUrl = uploadResponse.data['url'];
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File uploaded successfully!')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload failed: ${uploadResponse.error}')),
          );
        }
      }
    }
  }

  Future<void> _testApi() async {
    final data = <String, dynamic>{};

    // Get text values
    for (var entry in _controllers.entries) {
      data[entry.key] = entry.value.text;
    }

    // Get dropdown/other values
    data.addAll(_values);

    // Add uploaded file URL if exists
    if (_uploadedFileUrl != null) {
      data['image_url'] = _uploadedFileUrl;
    }

    setState(() {
      _isLoading = true;
      _response = null;
    });

    final response = await ApiService.callApi(widget.endpoint, data);

    setState(() {
      _isLoading = false;
      _response = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          widget.modelName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.description),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // File upload if required
                if (widget.requiresFileUpload) ...[
                  ElevatedButton.icon(
                    onPressed: _pickFile,
                    icon: const Icon(Icons.upload_file),
                    label: Text(_selectedFilePath != null
                        ? 'File: ${_selectedFilePath!.split('/').last}'
                        : 'Upload File'),
                  ),
                  const SizedBox(height: 8),
                  if (_uploadedFileUrl != null)
                    Text(
                      'Uploaded: $_uploadedFileUrl',
                      style: const TextStyle(fontSize: 12, color: Colors.green),
                    ),
                  const SizedBox(height: 16),
                ],

                // Parameters
                ...widget.parameters.map((param) => _buildParameter(param)),

                const SizedBox(height: 16),

                // Test button
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _testApi,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Test API'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                  ),
                ),

                const SizedBox(height: 16),

                // Loading indicator
                if (_isLoading)
                  const LoadingIndicator(message: 'Calling API...'),

                // Response
                if (_response != null) ...[
                  if (_response!.success) ...[
                    if (_response!.data != null)
                      _buildSuccessResult(_response!.data),
                  ] else ...[
                    ErrorDisplay(
                      error: _response!.error ?? 'Unknown error',
                      stackTrace: _response!.stackTrace,
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParameter(ApiParameter param) {
    if (param.type == 'text') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: TextField(
          controller: _controllers[param.name],
          decoration: InputDecoration(
            labelText: param.label,
            border: const OutlineInputBorder(),
            helperText: param.description,
          ),
          maxLines: param.name == 'prompt' ? 3 : 1,
        ),
      );
    } else if (param.type == 'dropdown') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: DropdownButtonFormField<String>(
          value: _values[param.name] ?? param.defaultValue,
          decoration: InputDecoration(
            labelText: param.label,
            border: const OutlineInputBorder(),
          ),
          items: param.options!
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _values[param.name] = value;
            });
          },
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildSuccessResult(dynamic data) {
    // Try to parse as media result
    if (data is Map<String, dynamic>) {
      if (data.containsKey('url') && data.containsKey('type')) {
        return MediaResultDisplay(
          url: data['url'],
          type: data['type'],
          metadata: data['metadata'],
        );
      }
    }

    // Fallback to JSON display
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                'Success',
                style: TextStyle(
                  color: Colors.green[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SelectableText(
            data.toString(),
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }
}

class ApiParameter {
  final String name;
  final String label;
  final String type; // 'text', 'dropdown'
  final String? description;
  final String? defaultValue;
  final List<String>? options;

  ApiParameter({
    required this.name,
    required this.label,
    required this.type,
    this.description,
    this.defaultValue,
    this.options,
  });
}

