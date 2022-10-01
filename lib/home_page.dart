import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<String> data;

  const HomePage({
    super.key,
    required this.data,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _gridKey = GlobalKey();
  final GlobalKey _logoKey = GlobalKey();

  double? _logoHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() => LayoutBuilder(
        builder: (context, constrains) {
          // Called after empty future, so calculation will be made only after build is
          // finished, when sizes will be known.
          //
          // Called in every build instead of only once in initState() in case
          // screen height will be changed (after screen orientation change, for example).
          Future.value().then((value) {
            _logoResize(screenHeight: constrains.maxHeight);
          });

          return SingleChildScrollView(
            child: Column(
              children: [
                // Logo
                Container(
                  height: _logoHeight,
                  alignment: Alignment.center,
                  child: Padding(
                    key: _logoKey,
                    padding: const EdgeInsets.all(30),
                    child: Image.asset('assets/logo.png'),
                  ),
                ),

                // Items
                GridView.count(
                  key: _gridKey,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  shrinkWrap: true,
                  children: widget.data.map((e) => Tile(text: e)).toList(),
                ),
              ],
            ),
          );
        },
      );

  /// Calculate available space for the logo
  void _logoResize({required double screenHeight}) {
    final double? gridHeight = _gridKey.currentContext?.size?.height;
    final double? logoHeight = _logoKey.currentContext?.size?.height;

    // If method called before first frame
    if (gridHeight == null || logoHeight == null) return;

    final double availableSpace = screenHeight - gridHeight;
    final double newLogoHeight = availableSpace < logoHeight ? logoHeight : availableSpace;

    // Rebuild screen only if its height changed
    if (_logoHeight != newLogoHeight) {
      setState(() {
        _logoHeight = newLogoHeight;
      });
    }
  }
}

class Tile extends StatelessWidget {
  final String text;

  const Tile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: _decoration(),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 22),
      ),
    );
  }

  BoxDecoration _decoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.black,
      ),
    );
  }
}
