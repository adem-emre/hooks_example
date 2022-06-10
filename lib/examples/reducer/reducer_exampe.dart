import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const url =
    "https://m.media-amazon.com/images/I/61rFf3FHRcL._AC_SY780_.jpg";

enum Action { rotateLeft, rotateRight, moreVisible, lessVisible }

@immutable
class State {
  final double rotationDeg;
  final double alpha;

  const State({required this.rotationDeg, required this.alpha});

  const State.zero()
      : alpha = 1,
        rotationDeg = 0;

  State rotateRight() => State(rotationDeg: rotationDeg + 10, alpha: alpha);
  State rotateLeft() => State(rotationDeg: rotationDeg - 10, alpha: alpha);
  State increaseAlpha() =>
      State(rotationDeg: rotationDeg, alpha: min(alpha + 0.1, 1));
  State decreaseAlpha() =>
      State(rotationDeg: rotationDeg, alpha: max(alpha - 0.1, 0));
}

State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.rotateLeft:
      return oldState.rotateLeft();

    case Action.rotateRight:
      return oldState.rotateRight();

    case Action.moreVisible:
      return oldState.increaseAlpha();

    case Action.lessVisible:
      return oldState.decreaseAlpha();

    case null:
      return oldState;
  }
}

class ReducerExample extends HookWidget {
  const ReducerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = useReducer<State, Action?>(reducer,
        initialState: const State.zero(), initialAction: null);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reducer Example'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.rotateLeft);
                  },
                  child: const Text("Rotate Left")),
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.rotateRight);
                  },
                  child: const Text("Rotate Right")),
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.moreVisible);
                  },
                  child: const Text("More Visible")),
              TextButton(
                  onPressed: () {
                    store.dispatch(Action.lessVisible);
                  },
                  child: const Text("Less Visible")),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Opacity(
            opacity: store.state.alpha,
            child: RotationTransition(
                turns: AlwaysStoppedAnimation(store.state.rotationDeg / 360),
                child: Image.network(
                  url,
                  width: 300,
                  height: 300,
                )),
          ),
        ],
      ),
    );
  }
}
