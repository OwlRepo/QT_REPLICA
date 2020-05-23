import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/services.dart';


const _assetsToWarmup = [
  "assets/Animations/MicButtonSend.flr",
];

Future<void> PreLoadFlare() async {
  for (final filename in _assetsToWarmup) {
    await cachedActor(AssetFlare(bundle: rootBundle, name: filename));
    await Future<void>.delayed(const Duration(milliseconds: 16));
  }
}