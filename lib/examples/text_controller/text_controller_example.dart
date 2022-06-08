import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

class TextControllerExample extends HookWidget {
  const TextControllerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final text = useState('Lorem');
    useEffect(() {
      controller.addListener(() {
        text.value = controller.text;
      });
      return null;
    }, [controller]);

    return Scaffold(
      appBar: AppBar(title: const Text('TextController Example')),
      body: Column(
        children: <Widget>[
          TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Text'),
          ),
          Center(
            child: Text(
              text.value,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
