import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:any_syntax_highlighter/any_syntax_highlighter.dart';

class CodeView extends StatelessWidget {
  const CodeView(this.file, {super.key});

  final PlatformFile file;

  @override
  Widget build(BuildContext context) {
    return AnySyntaxHighlighter(
      String.fromCharCodes(file.bytes!),
      useGoogleFont: 'Roboto Mono',
      hasCopyButton: true,
      isSelectableText: true,
      lineNumbers: true,
      padding: 10,
    );
  }
}
