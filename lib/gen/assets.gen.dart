// dart format width=100

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsProjectsGen {
  const $AssetsProjectsGen();

  /// Directory path: assets/projects/compass-ble
  $AssetsProjectsCompassBleGen get compassBle => const $AssetsProjectsCompassBleGen();

  /// File path: assets/projects/index.json
  String get index => 'assets/projects/index.json';

  /// Directory path: assets/projects/torpedo
  $AssetsProjectsTorpedoGen get torpedo => const $AssetsProjectsTorpedoGen();

  /// List of all assets
  List<String> get values => [index];
}

class $AssetsStickersGen {
  const $AssetsStickersGen();

  /// File path: assets/stickers/too-narrow-placeholder.png
  AssetGenImage get tooNarrowPlaceholder =>
      const AssetGenImage('assets/stickers/too-narrow-placeholder.png');

  /// List of all assets
  List<AssetGenImage> get values => [tooNarrowPlaceholder];
}

class $AssetsProjectsCompassBleGen {
  const $AssetsProjectsCompassBleGen();

  /// File path: assets/projects/compass-ble/README.md
  String get readme => 'assets/projects/compass-ble/README.md';

  /// File path: assets/projects/compass-ble/compass-ble.md
  String get compassBle => 'assets/projects/compass-ble/compass-ble.md';

  /// Directory path: assets/projects/compass-ble/images
  $AssetsProjectsCompassBleImagesGen get images => const $AssetsProjectsCompassBleImagesGen();

  /// List of all assets
  List<String> get values => [readme, compassBle];
}

class $AssetsProjectsTorpedoGen {
  const $AssetsProjectsTorpedoGen();

  /// File path: assets/projects/torpedo/README.md
  String get readme => 'assets/projects/torpedo/README.md';

  /// Directory path: assets/projects/torpedo/images
  $AssetsProjectsTorpedoImagesGen get images => const $AssetsProjectsTorpedoImagesGen();

  /// File path: assets/projects/torpedo/torpedo.md
  String get torpedo => 'assets/projects/torpedo/torpedo.md';

  /// List of all assets
  List<String> get values => [readme, torpedo];
}

class $AssetsProjectsCompassBleImagesGen {
  const $AssetsProjectsCompassBleImagesGen();

  /// File path: assets/projects/compass-ble/images/ScanDevicesUseCase.png
  AssetGenImage get scanDevicesUseCase =>
      const AssetGenImage('assets/projects/compass-ble/images/ScanDevicesUseCase.png');

  /// File path: assets/projects/compass-ble/images/ci_1.png
  AssetGenImage get ci1 => const AssetGenImage('assets/projects/compass-ble/images/ci_1.png');

  /// File path: assets/projects/compass-ble/images/ci_2.png
  AssetGenImage get ci2 => const AssetGenImage('assets/projects/compass-ble/images/ci_2.png');

  /// File path: assets/projects/compass-ble/images/cover.jpg
  AssetGenImage get cover => const AssetGenImage('assets/projects/compass-ble/images/cover.jpg');

  /// File path: assets/projects/compass-ble/images/getConnector.png
  AssetGenImage get getConnector =>
      const AssetGenImage('assets/projects/compass-ble/images/getConnector.png');

  /// File path: assets/projects/compass-ble/images/nativeBleManager.png
  AssetGenImage get nativeBleManager =>
      const AssetGenImage('assets/projects/compass-ble/images/nativeBleManager.png');

  /// File path: assets/projects/compass-ble/images/nativeSetup.png
  AssetGenImage get nativeSetup =>
      const AssetGenImage('assets/projects/compass-ble/images/nativeSetup.png');

  /// File path: assets/projects/compass-ble/images/requestEnableBluetooth.png
  AssetGenImage get requestEnableBluetooth =>
      const AssetGenImage('assets/projects/compass-ble/images/requestEnableBluetooth.png');

  /// File path: assets/projects/compass-ble/images/scanFilterUuids.png
  AssetGenImage get scanFilterUuids =>
      const AssetGenImage('assets/projects/compass-ble/images/scanFilterUuids.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    scanDevicesUseCase,
    ci1,
    ci2,
    cover,
    getConnector,
    nativeBleManager,
    nativeSetup,
    requestEnableBluetooth,
    scanFilterUuids,
  ];
}

class $AssetsProjectsTorpedoImagesGen {
  const $AssetsProjectsTorpedoImagesGen();

  /// File path: assets/projects/torpedo/images/1234.png
  AssetGenImage get a1234 => const AssetGenImage('assets/projects/torpedo/images/1234.png');

  /// File path: assets/projects/torpedo/images/ble_enabler.png
  AssetGenImage get bleEnabler =>
      const AssetGenImage('assets/projects/torpedo/images/ble_enabler.png');

  /// File path: assets/projects/torpedo/images/cover.png
  AssetGenImage get cover => const AssetGenImage('assets/projects/torpedo/images/cover.png');

  /// List of all assets
  List<AssetGenImage> get values => [a1234, bleEnabler, cover];
}

class Assets {
  const Assets._();

  static const $AssetsProjectsGen projects = $AssetsProjectsGen();
  static const $AssetsStickersGen stickers = $AssetsStickersGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}, this.animation});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
