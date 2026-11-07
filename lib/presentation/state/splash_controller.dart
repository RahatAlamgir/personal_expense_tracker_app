import 'package:flutter/foundation.dart';

/// Loads data while the splash is showing, then asks the app to move on.
class SplashController extends ChangeNotifier {
  SplashController({
    required this.load,
    required this.onFinished,
    this.minimumDuration = const Duration(milliseconds: 1800),
  });

  final Future<void> Function() load;
  final VoidCallback onFinished;
  /// The splash stays at least this long so it never just flashes.
  final Duration minimumDuration;

  bool _disposed = false;

  /// Waits for both the data load and the minimum splash time, then calls [onFinished].
  Future<void> start() async {
    await Future.wait([load(), Future<void>.delayed(minimumDuration)]);
    if (!_disposed) onFinished();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
