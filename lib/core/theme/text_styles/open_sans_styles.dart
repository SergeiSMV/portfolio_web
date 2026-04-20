import 'package:flutter/material.dart';

/// Набор базовых TextStyle для шрифта OpenSans.
///
/// Здесь храним только семейство шрифта + размер/вес.
/// Цвет, высота строки и letterSpacing обычно задаются в слое темы.
final class OpenSansStyles {
  const OpenSansStyles();

  // Regular
  final TextStyle openSans12 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  final TextStyle openSans14 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  final TextStyle openSans16 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  final TextStyle openSans18 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
  final TextStyle openSans20 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  // Medium
  final TextStyle mediumOpenSans11 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
  final TextStyle mediumOpenSans12 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  final TextStyle mediumOpenSans14 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  final TextStyle mediumOpenSans16 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  // SemiBold
  final TextStyle semiBoldOpenSans11 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
  final TextStyle semiBoldOpenSans12 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  final TextStyle semiBoldOpenSans14 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  final TextStyle semiBoldOpenSans16 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  final TextStyle semiBoldOpenSans22 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );
  final TextStyle semiBoldOpenSans24 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // Bold
  final TextStyle boldOpenSans14 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  final TextStyle boldOpenSans16 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  final TextStyle boldOpenSans18 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  final TextStyle boldOpenSans20 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  final TextStyle boldOpenSans22 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );
  final TextStyle boldOpenSans24 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  final TextStyle boldOpenSans28 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );
  final TextStyle boldOpenSans32 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );
  final TextStyle boldOpenSans36 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );

  // ExtraBold
  final TextStyle extraBoldOpenSans16 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );
  final TextStyle extraBoldOpenSans36 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 36,
    fontWeight: FontWeight.w800,
  );
  final TextStyle extraBoldOpenSans38 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 38,
    fontWeight: FontWeight.w800,
  );
  final TextStyle extraBoldOpenSans40 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 40,
    fontWeight: FontWeight.w800,
  );
  final TextStyle extraBoldOpenSans45 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 45,
    fontWeight: FontWeight.w800,
  );
  final TextStyle extraBoldOpenSans56 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 56,
    fontWeight: FontWeight.w800,
  );
  final TextStyle extraBoldOpenSans57 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 57,
    fontWeight: FontWeight.w800,
  );
  final TextStyle extraBoldOpenSans64 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 64,
    fontWeight: FontWeight.w800,
  );
  final TextStyle extraBoldOpenSans68 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 68,
    fontWeight: FontWeight.w800,
  );
  final TextStyle extraBoldOpenSans84 = const TextStyle(
    fontFamily: 'OpenSans',
    fontSize: 84,
    fontWeight: FontWeight.w800,
  );
}
