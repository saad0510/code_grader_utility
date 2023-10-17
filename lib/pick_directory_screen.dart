import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'file_detail_screen.dart';

class PickDirectoryScreen extends StatelessWidget {
  const PickDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Grader'),
      ),
      body:  Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(color: Colors.blue),
                ),
                child: TextButton(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
                    if (result == null || result.files.isEmpty) return;
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FileDetailScreen(
                          currentIndex: 0,
                          files: result.files,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: size.width * 0.5,
                    height: size.height * 0.5,
                    child: const Center(
                      child: Text(
                        'Add Directory',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
