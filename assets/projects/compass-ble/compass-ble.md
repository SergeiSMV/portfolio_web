---
slug: compass-ble
title: Compass BLE
role: IoT Flutter Developer
period: 2026 - настоящее время
client: НПО "Компас" (Stark)
summary: Кроссплатформенное Flutter-приложение для BLE-мониторинга BMS (JK, Daly и др.) с нативным Android BLE-каналом для сложных устройств, дашбордом телеметрии и локальным хранением пользовательских настроек.
cover: assets/projects/compass-ble/images/cover.jpg
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
   - добавление _GitHub_ _Actions_ _CI_.

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
- ***presentation*** - страницы, виджеты, _BLoC_ / _Cubit_;
- ***domain*** - сущности, контракты и use cases;
- ***data*** - реализация репозиториев, протоколы, BLE-коннекторы, локальная БД;
- ***core*** - DI, логирование, константы, генерируемые ресурсы, платформенные абстракции.
Ключевые технические решения:
- единый BLoC-пайплайн для BLE состояния и пользовательских потоков;
- обособленные коннекторы под разные устройства/протоколы;
- fallback/special-case сценарии через _platform_ _channels_ там, где стандартного BLE-плагина недостаточно;
- хранение пользовательских данных (например, custom name устройств) в локальной БД;
- централизованная инициализация зависимостей и логирования.

## Детальная структура модулей
- **Core**
  - DI (_get_it_, _injectable_), logger (_talker_), constants/enums, theme, generated assets/strings.
- **Data**
  - BLE connectors (ble_device_connector, jk_dual_char_connector);
  - protocol parsers (ffe0, fff0, packet assembler, protocol factory);
  - repositories (ble_data_source_impl, bms_repository_impl);
  - local DB (_drift_).


![BLE connector](assets/projects/compass-ble/images/getConnector.png)


- **Domain**
  - entities: snapshot, errors, cells, devices;
  - repositories interfaces;
  - use cases: scan, connect, disconnect, observe status, stream device, enable bluetooth, rename device.

![BLE device usecase](assets/projects/compass-ble/images/ScanDevicesUseCase.png)


- **Presentation**
  - pages: splash, permissions, scan, dashboard;
  - blocs: ble_status, scan, device_manager, device_monitor, root_page_index;
  - widgets: scan cards/lists, dashboard sections, gauges, error indicators, rename dialogs.

## Platform Channels (детально)
В проекте есть осознанное использование _platform_ _channels_ для сценариев, где нужен контроль над нативным BLE-поведением.

#### 1. BLE Enabler channel
Назначение: инициировать системный сценарий включения Bluetooth без выхода из приложения.
- Channel: com.compass.stark/ble_enabler
- Тип: MethodChannel
- Android: MainActivity.kt (BluetoothAdapter.ACTION_REQUEST_ENABLE)
- iOS: AppDelegate.swift (CBCentralManagerOptionShowPowerAlertKey)

![BLE request enable](assets/projects/compass-ble/images/requestEnableBluetooth.png)

#### 2. Native BLE manager channels (Android-only)

- Method channel: _com.compass.stark/native_ble_
- Event channel: _com.compass.stark/native_ble_notify_
- Android implementation:
  - _android/app/src/main/kotlin/com/compass/stark/MainActivity.kt_
  - _android/app/src/main/kotlin/com/compass/stark/NativeBleManager.kt_

![BLE Manager](assets/projects/compass-ble/images/nativeBleManager.png)

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

![BLE scan filter](assets/projects/compass-ble/images/scanFilterUuids.png)


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
  - _flutter_bloc_, _equatable_
- **Dependency injection**
  - _et_it_, _injectable_
- **BLE**
  - _flutter_reactive_ble_
  - _Platform_ _channels_ + _Kotlin_ native BLE manager (Android)
- **Data layer**
  - _drift_, _drift_flutter_, _path_provider_
- **FP/error handling**
  - _either_dart_
- **Logging/observability**
  - _talker_flutter_, _talker_bloc_logger_
- **Localization/codegen**
  - _slang_, _slang_flutter_
  - _build_runner_, _drift_dev_, _flutter_gen_
- **UI/UX packages**
  - _google_nav_bar_, _material_design_icons_flutter_, _lottie_,
    _loading_animation_widget_, _animated_text_kit_, _animated_snack_bar_
- **CI/CD**
  - _GitHub_ _Actions_:
    - dart format --set-exit-if-changed .
    - flutter analyze
    - flutter test
    - flutter build apk --release
    - публикация APK артефакта

![BLE github action part1](assets/projects/compass-ble/images/ci_1.png)

![BLE github action part2](assets/projects/compass-ble/images/ci_2.png)

## Роль и зона ответственности
Полный цикл Flutter-разработки в проекте:
- проектирование архитектуры и слоёв;
- реализация BLE-сценариев и протокольной интеграции;
- разработка UI и пользовательских потоков;
- нативная интеграция через _platform_ _channels_ (Android/Kotlin, iOS/Swift);
- настройка _CI_ и quality gates;
- рефакторинг и техническая стабилизация при росте функциональности.

## Ограничения и технические нюансы
- BLE-поведение заметно различается между Android/iOS, часть логики платформо-специфична.
- Для отдельных устройств требуется нативный Android путь из-за особенностей характеристик.
- Реальная валидация BLE-сценариев требует тестов на физических устройствах.

![BLE native setup](assets/projects/compass-ble/images/nativeSetup.png)


## Дальнейшие шаги
- Расширение матрицы поддерживаемых BMS-протоколов.
- Добавление глубокой диагностики каналов и телеметрии подключения.
- Усиление automated tests (unit/widget/integration) для ключевых BLE-use-cases.
- Подготовка продуктовой документации и публичного case-описания при необходимости.
