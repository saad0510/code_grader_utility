import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'code_view.dart';

class FileDetailScreen extends StatefulWidget {
  const FileDetailScreen({
    super.key,
    required this.currentIndex,
    required this.files,
  });

  final int currentIndex;
  final List<PlatformFile> files;

  @override
  State<FileDetailScreen> createState() => _FileDetailScreenState();
}

class _FileDetailScreenState extends State<FileDetailScreen> {
  int grade = 1;
  String task = 'a';

  @override
  Widget build(BuildContext context) {
    final openedFile = widget.files[widget.currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(openedFile.name),
            const Spacer(),
            const SizedBox(width: 5),
            Text('task_$task'),
            const SizedBox(width: 20),
            const Icon(
              Icons.grade,
              color: Colors.orangeAccent,
            ),
            const SizedBox(width: 5),
            Text('$grade'),
            const SizedBox(width: 20),
            Text(
              '${widget.currentIndex + 1}/${widget.files.length}',
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: CodeView(openedFile),
      ),
    );
  }

  bool _onKey(KeyEvent event) {
    if (event is KeyDownEvent) return true;
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowLeft) {
      gotoPrevFile();
    } else if (key == LogicalKeyboardKey.arrowRight) {
      gotoNextFile();
    } else if (key == LogicalKeyboardKey.enter) {
      gotoNextFile();
    } else {
      useLabel(key.keyLabel);
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.keyboard.addHandler(_onKey);
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_onKey);
    super.dispose();
  }

  void gotoNextFile() {
    final nextIndex = (widget.currentIndex + 1) % widget.files.length;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FileDetailScreen(
          currentIndex: nextIndex,
          files: widget.files,
        ),
      ),
    );
  }

  void gotoPrevFile() {
    final prevIndex = (widget.currentIndex - 1) % widget.files.length;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => FileDetailScreen(
          currentIndex: prevIndex,
          files: widget.files,
        ),
      ),
    );
  }

  void useLabel(String label) {
    final number = int.tryParse(label);
    if (number != null) {
      if (number >= 1 && number <= 5) {
        setState(() => grade = number);
      }
    } else {
      if (label.length == 1) {
        setState(() => task = label.toLowerCase());
      }
    }
  }
}
