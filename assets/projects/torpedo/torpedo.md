---
slug: compass-ble
title: Compass BLE
role: Senior Flutter Developer
period: 2026 - настоящее время
client: НПО "Компас" (Stark)
summary: Кроссплатформенное Flutter-приложение для BLE-мониторинга BMS (JK, Daly и др.) с нативным Android BLE-каналом для сложных устройств, дашбордом телеметрии и локальным хранением пользовательских настроек.
cover: assets/projects/compass-ble/images/1234.png
tags: [mobile, flutter, ble, bms, iot, monitoring]
stack:
  - Flutter
  - Dart
  - flutter_bloc
  - get_it
  - injectable
  - flutter_reactive_ble
  - Drift
  - Slang
  - GitHub Actions
  - Kotlin
  - Swift
platforms: [Android, iOS]
links:
  github: https://github.com/SergeiSMV
featured: true
order: 1
---

## Задача
Единое мобильное приложение для работы с Bluetooth Low Energy BMS-устройствами:
- быстрое и стабильное сканирование BLE-устройств;
- безопасное подключение/отключение и отображение статуса соединения;
- визуализация ключевой телеметрии батареи в реальном времени (ячейки, температура, ошибки, остаток заряда, заряд/разряд);
- поддержка разных линеек BMS с разными протоколами и особенностями BLE-реализации;
- удобный UX для системных разрешений и включения Bluetooth;
- готовность к росту: расширяемая архитектура, CI-проверки, поддерживаемый код.

Бизнес-контекст: приложение используется как инженерный/операционный инструмент для диагностики и мониторинга аккумуляторных систем через BLE в полевых условиях.

## Ключевые этапы разработки:

#### 1. Базовая структура и инфраструктура
   - формирование структуры модулей приложения;
   - подключение ассетов и шрифтов;
   - добавление GitHub Actions CI.

#### 2. Домен и данные
   - введение сущностей BMS и enum-моделей;
   - подключение зависимостей для локальной БД;
   - развитие BLE data source, фиксы UUID/характеристик.

#### 3. Use case-ориентированный слой
   - добавлены сценарии: BLE status, scan, connect/disconnect, device stream, request enable Bluetooth;
   - замена polling-подхода для статуса BLE на event-oriented поведение (BleStatusSetOn).

#### 4. UI-слой и навигация
   - рефакторинг страницы разрешений;
   - добавление root-page индекса и нижней навигации;
   - крупные улучшения scan-экрана и подключений.

#### 5. Мониторинг и dashboard
   - запуск dashboard-страницы с компонентами телеметрии;
   - фиксы lifecycle/логирования device monitor bloc;
   - добавление пользовательских имён BMS.

#### 6. Углубление протокольной поддержки
   - шаги по поддержке JK-BD4A8S4P;
   - декомпозиция BLE connector и внедрение нативного Android BLE manager;
   - фиксы iOS UUID-поведения.

#### 7. Расширение покрываемых устройств и UX
   - добавление Daly BMS;
   - обновление иконок, splash screen;
   - обновление scanDevices для DL-T серии;
   - обновление UI и переводов scan/dashboard.

## Решение
Реализована модульная архитектура с разделением ответственности по слоям:
- ***presentation*** - страницы, виджеты, BLoC/Cubit;
- ***domain*** - сущности, контракты и use cases;
- ***data*** - реализация репозиториев, протоколы, BLE-коннекторы, локальная БД;
- ***core*** - DI, логирование, константы, генерируемые ресурсы, платформенные абстракции.
Ключевые технические решения:
- единый BLoC-пайплайн для BLE состояния и пользовательских потоков;
- обособленные коннекторы под разные устройства/протоколы;
- fallback/special-case сценарии через platform channels там, где стандартного BLE-плагина недостаточно;
- хранение пользовательских данных (например, custom name устройств) в локальной БД;
- централизованная инициализация зависимостей и логирования.

## Детальная структура модулей
- **Core**
  - DI (get_it, injectable), logger (talker), constants/enums, theme, generated assets/strings.
- **Data**
  - BLE connectors (ble_device_connector, jk_dual_char_connector);
  - protocol parsers (ffe0, fff0, packet assembler, protocol factory);
  - repositories (ble_data_source_impl, bms_repository_impl);
  - local DB (drift).
- **Domain**
  - entities: snapshot, errors, cells, devices;
  - repositories interfaces;
  - use cases: scan, connect, disconnect, observe status, stream device, enable bluetooth, rename device.
- **Presentation**
  - pages: splash, permissions, scan, dashboard;
  - blocs: ble_status, scan, device_manager, device_monitor, root_page_index;
  - widgets: scan cards/lists, dashboard sections, gauges, error indicators, rename dialogs.

## Platform Channels (детально)
В проекте есть осознанное использование platform channels для сценариев, где нужен контроль над нативным BLE-поведением.

#### 1. BLE Enabler channel
- Channel: com.compass.stark/ble_enabler
- Тип: MethodChannel
- Dart: lib/core/platform/ble_enabler.dart
- Android: MainActivity.kt (BluetoothAdapter.ACTION_REQUEST_ENABLE)
- iOS: AppDelegate.swift (CBCentralManagerOptionShowPowerAlertKey)

![BLE Enabler](assets/projects/compass-ble/images/ble_enabler.png)

Назначение: инициировать системный сценарий включения Bluetooth без выхода из приложения.

#### 2. Native BLE manager channels (Android-only)
- Method channel: com.compass.stark/native_ble
- Event channel: com.compass.stark/native_ble_notify
- Dart wrapper: lib/core/platform/native_ble_manager.dart
- Android implementation:
  - android/app/src/main/kotlin/com/compass/stark/MainActivity.kt
  - android/app/src/main/kotlin/com/compass/stark/NativeBleManager.kt

Назначение: полный нативный BLE-цикл для проблемных устройств с неоднозначными/дублирующимися characteristic UUID:

- connect
- request MTU
- discover + setup notify/write
- write
- disconnect
- isConnected
- stream notify events через EventChannel
Интеграция с data-слоем:
- используется native path на Android;
- на iOS сохраняется путь через flutter_reactive_ble.

## Что реализовано по функционалу
- Экран разрешений и onboarding-переход в основной поток.
- BLE-сканирование устройств со списком результатов.
- Управление подключением/отключением + отображение connection state.
- Дашборд с телеметрией BMS:
  - секция температур;
  - секция напряжений ячеек;
  - секция ошибок;
  - battery remain и индикаторы.
- Сохранение и очистка пользовательских имён устройств.
- Splash screen, дизайн-обновления, локализация.

## Результаты
- Сформирована рабочая production-oriented база приложения для BLE BMS-мониторинга.
- Обеспечена расширяемость под новые BMS-протоколы и устройства.
- Закрыт критичный Android BLE-кейс через нативный менеджер для сложных характеристик.
- Повышена стабильность UX:
  - улучшен flow разрешений/включения Bluetooth;
  - устранены проблемы сканирования для DL-T серии;
  - исправлены lifecycle/logging edge-cases в мониторинге устройства.
- Подключён CI-контур качества и сборки артефакта APK в GitHub Actions.

## Инструменты и стек (подробно)
- **Flutter/Dart**
  - Flutter SDK stable в CI (3.24.x)
  - Dart SDK ^3.10.4
- **State management**
  - flutter_bloc, equatable
- **Dependency injection**
  - get_it, injectable
- **BLE**
  - flutter_reactive_ble
  - Platform channels + Kotlin native BLE manager (Android)
- **Data layer**
  - drift, drift_flutter, path_provider
- **FP/error handling**
  - either_dart
- **Logging/observability**
  - talker_flutter, talker_bloc_logger
- **Localization/codegen**
  - slang, slang_flutter
  - build_runner, drift_dev, flutter_gen
- **UI/UX packages**
  - google_nav_bar, material_design_icons_flutter, lottie,
    loading_animation_widget, animated_text_kit, animated_snack_bar
- **CI/CD**
  - GitHub Actions:
    - dart format --set-exit-if-changed .
    - flutter analyze
    - flutter test
    - flutter build apk --release
    - публикация APK артефакта

## Роль и зона ответственности
Полный цикл Flutter-разработки в проекте:
- проектирование архитектуры и слоёв;
- реализация BLE-сценариев и протокольной интеграции;
- разработка UI и пользовательских потоков;
- нативная интеграция через platform channels (Android/Kotlin, iOS/Swift);
- настройка CI и quality gates;
- рефакторинг и техническая стабилизация при росте функциональности.

## Ограничения и технические нюансы
- BLE-поведение заметно различается между Android/iOS, часть логики платформо-специфична.
- Для отдельных устройств требуется нативный Android путь из-за особенностей характеристик.
- Реальная валидация BLE-сценариев требует тестов на физических устройствах.

## Дальнейшие шаги
- Расширение матрицы поддерживаемых BMS-протоколов.
- Добавление глубокой диагностики каналов и телеметрии подключения.
- Усиление automated tests (unit/widget/integration) для ключевых BLE-use-cases.
- Подготовка продуктовой документации и публичного case-описания при необходимости.
