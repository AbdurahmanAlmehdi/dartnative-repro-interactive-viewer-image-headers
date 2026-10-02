import 'package:dartnative/dartnative.dart';

import 'dartnative_plugin_registrant.dart';

void main() {
  DartNativePluginRegistrant.registerAll();
  runApp(const ViewerRepro());
}

class ViewerRepro extends StatefulWidget {
  const ViewerRepro({super.key});

  @override
  State<ViewerRepro> createState() => _ViewerReproState();
}

class _ViewerReproState extends State<ViewerRepro> {
  int _pinches = 0;
  double _lastScale = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      brightness: Brightness.light,
      appBar: AppBar(title: const Text('Receipt viewer')),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('No InteractiveViewer, no Image.network(headers:)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                const Text(
                  'Expected (Flutter): pinch the receipt to zoom in and pan, '
                  'InteractiveViewer(maxScale: 5, child: Image.network(url, headers: {...})).',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  'Actual: the image stays at 1x. Pinches seen by a GestureDetector: '
                  '$_pinches (last scale ${_lastScale.toStringAsFixed(2)}).',
                  style: const TextStyle(fontSize: 13, color: Color(0xFFC62828)),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleEnd: (_) => setState(() => _pinches++),
              onScaleUpdate: (d) => _lastScale = d.scale,
              child: Container(
                color: const Color(0xFF202020),
                child: Image.asset('assets/receipt.png', fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
