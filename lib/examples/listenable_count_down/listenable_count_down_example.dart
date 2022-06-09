import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;
  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(const Duration(milliseconds: 500), (v) => from - v)
        .takeWhile((value) => value >= 0)
        .listen((value) {
      this.value = value;
    });
  }
  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}

class ListenableCountDownExample extends HookWidget {
  const ListenableCountDownExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(() => CountDown(from: 20));
    final notifier = useListenable(countDown);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listenable Count Down Example'),
      ),
      body: Center(
        child: Text(
          notifier.value.toString(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
