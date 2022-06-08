import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_example/extensions/iterable_ext.dart';

const url = "https://bit.ly/3qYOtDm";

class ImageLoadExample extends HookWidget {
  const ImageLoadExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("Build called");
    final future = useMemoized(() => NetworkAssetBundle(Uri.parse(url))
        .load(url)
        .then((data) => data.buffer.asUint8List())
        .then((image) => Image.memory(image)));

    final snapshot = useFuture(future);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Load Example '),
        ),
        body: Column(
          children: [snapshot.data].compactMap().toList(),
        ));
  }
}
