import 'package:flare_flutter/asset_provider.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';

final AssetProvider assetProvider = AssetFlare(name: 'assets/Animations/MicButtonSend.flr');

Future<void> PreLoadFlare() async {
await cachedActor(assetProvider);
}