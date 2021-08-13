import 'dart:io';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String url;
  final double size;
  final File imageFile;

  const Avatar({Key key, this.url, this.imageFile, this.size = 25.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundImage: url != null
          ? NetworkImage(url)
          : imageFile != null
              ? FileImage(imageFile)
              : null,
      child: url == null && imageFile == null
          ? Icon(Icons.person_outline, size: size)
          : null,
    );
  }
}
