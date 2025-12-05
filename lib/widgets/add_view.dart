import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../l10n/app_localizations.dart';
import '../config/api_config.dart';
import 'package:intl/intl.dart';

class AddView extends StatefulWidget {
  final VoidCallback? onUploadSuccess;
  final String username;

  const AddView({super.key, this.onUploadSuccess, required this.username});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  bool _isCameraMode = false; // false = File, true = Camera
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  // Camera variables
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;
  bool _isCameraInitialized = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Camera is initialized only when switching to Camera mode
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _onNewCameraSelected(_cameras![_selectedCameraIndex]);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  Future<void> _onNewCameraSelected(CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller!.dispose();
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _controller = cameraController;

    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        if (mounted) {
          setState(() {
            _errorMessage = cameraController.value.errorDescription;
          });
        }
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.description;
        });
      }
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = _controller!.value.isInitialized;
      });
    }
  }

  void _toggleCamera() {
    if (_cameras == null || _cameras!.isEmpty) return;
    setState(() {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;
      _onNewCameraSelected(_cameras![_selectedCameraIndex]);
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _takePicture() async {
    if (!_isCameraInitialized ||
        _controller == null ||
        _controller!.value.isTakingPicture) {
      return;
    }

    try {
      final XFile image = await _controller!.takePicture();
      setState(() {
        _selectedImage = image;
      });
    } on CameraException catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.uploadingLabel)),
    );

    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/images');
      final request = http.MultipartRequest('POST', uri);
      request.fields['username'] = widget.username;

      // Read file bytes to support both Web and Mobile
      final bytes = await _selectedImage!.readAsBytes();

      String filename = _selectedImage!.name;

      if (_isCameraMode) {
        final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
        filename = 'foto_$timestamp.jpg';
      } else {
        // Ensure filename has an extension for file uploads if missing
        if (!filename.toLowerCase().endsWith('.jpg') &&
            !filename.toLowerCase().endsWith('.jpeg') &&
            !filename.toLowerCase().endsWith('.png')) {
          filename = '$filename.jpg';
        }
      }

      final multipartFile = http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: filename,
      );

      request.files.add(multipartFile);

      final response = await request.send();

      if (mounted) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.uploadSuccess),
              backgroundColor: Colors.green,
            ),
          );
          _resetSelection();
          widget.onUploadSuccess?.call();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(
                  context,
                )!.uploadFailed(response.statusCode.toString()),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.uploadFailed(e.toString()),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _resetSelection() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _onModeChanged(Set<bool> newSelection) {
    bool isCamera = newSelection.first;
    setState(() {
      _isCameraMode = isCamera;
      _selectedImage = null; // Reset image when switching modes
    });

    if (isCamera) {
      _initializeCamera();
    } else {
      _controller?.dispose();
      _controller = null;
      _isCameraInitialized = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SegmentedButton<bool>(
            segments: [
              ButtonSegment<bool>(
                value: false,
                label: Text(AppLocalizations.of(context)!.fileLabel),
                icon: const Icon(Icons.folder),
              ),
              ButtonSegment<bool>(
                value: true,
                label: Text(AppLocalizations.of(context)!.cameraLabel),
                icon: const Icon(Icons.camera_alt),
              ),
            ],
            selected: {_isCameraMode},
            onSelectionChanged: _onModeChanged,
          ),
        ),
        Expanded(
          child: Center(
            child: _selectedImage != null
                ? _buildPreviewView()
                : (_isCameraMode ? _buildCameraView() : _buildFileView()),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 300,
            width: 300,
            child: kIsWeb
                ? Image.network(_selectedImage!.path, fit: BoxFit.cover)
                : Image.file(File(_selectedImage!.path), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _resetSelection,
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context)!.retakeLabel),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton.icon(
              onPressed: _uploadImage,
              icon: const Icon(Icons.send),
              label: Text(AppLocalizations.of(context)!.sendLabel),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFileView() {
    return InkWell(
      onTap: _pickImage,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, size: 60, color: Colors.grey),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.pickImageLabel,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraView() {
    if (_errorMessage != null) {
      return Text(
        AppLocalizations.of(context)!.cameraError(_errorMessage!),
        style: const TextStyle(color: Colors.red),
      );
    }

    if (!_isCameraInitialized || _controller == null) {
      return const CircularProgressIndicator();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CameraPreview(_controller!),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _toggleCamera,
              icon: const Icon(Icons.cameraswitch, size: 30),
              tooltip: AppLocalizations.of(context)!.switchCamera,
            ),
            const SizedBox(width: 20),
            FloatingActionButton(
              onPressed: _takePicture,
              child: const Icon(Icons.camera),
            ),
            const SizedBox(width: 50), // Spacer to balance layout if needed
          ],
        ),
      ],
    );
  }
}
