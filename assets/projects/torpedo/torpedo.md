---
slug: torpedo-nn-mobile
title: Torpedo NN Mobile
role: Flutter Developer
period: 2025
client: ХК Торпедо
summary: Кроссплатформенное Flutter-приложение для болельщиков ХК Торпедо с матч-центром, билетами, медиа-контентом, личным кабинетом, push-уведомлениями и in-arena сервисами.
cover: assets/projects/torpedo/images/cover.png
tags: [mobile, flutter, sports, tickets, media, fan-app]
stack:
  - Flutter
  - Dart
  - flutter_bloc
  - get_it
  - injectable
  - auto_route
  - Dio
  - Drift
  - Firebase (Analytics, Crashlytics, Messaging)
  - VK ID SDK
  - Live Activities
  - Slang
platforms: [Android, iOS]
links:
  github: https://github.com/SergeiSMV
featured: true
order: 1
---

## Задача
Единое мобильное приложение клуба для ежедневных сценариев болельщика:
- новости, медиа и матч-центр в одном интерфейсе;
- покупка/просмотр билетов и управление пользовательскими тикетами;
- персональный профиль и настройки уведомлений;
- in-arena сценарии (навигация, QR, мои заказы);
- стабильная работа с аналитикой, push-уведомлениями и crash-репортингом.

Бизнес-контекст: приложение выступает основной mobile-точкой взаимодействия клуба с болельщиками, объединяя контент, матчевые активности, билеты, профиль и сервисы во время посещения арены.

## Ключевые этапы разработки:

#### 1. Базовая архитектура и инфраструктура
   - выстроена feature-first структура (core + features);
   - подключены DI, роутинг и codegen-цепочка;
   - настроены единые подходы к логированию и обработке ошибок.

#### 2. Домен и data-слой
   - сформированы доменные модели и контракты репозиториев;
   - реализованы remote/local data source и мапперы;
   - добавлено локальное хранение через _Drift_ и _SharedPreferences_.

#### 3. Навигация и пользовательские флоу
   - реализован nested-роутинг через _auto_route_;
   - объединены ключевые разделы: main, season, tickets, more;
   - добавлены сценарии onboarding/auth/profile/settings.

![Torpedo navigation](assets/projects/torpedo/images/navigation.png)

#### 4. Контентные и матчевые модули
   - реализованы блоки news, media, stories, tournament table;
   - добавлен match review для будущих/текущих/прошедших матчей;
   - внедрены webview и медиаплееры (YouTube, VK Video).

#### 5. Ticketing и in-arena сценарии
   - развиты модули tickets, user tickets и детали абонементов;
   - реализован контур in-arena: QR, заказы, навигация;
   - добавлены loyalty program и bonus history.

#### 6. Интеграции и observability
   - подключены _Firebase_ _Analytics_, _Crashlytics_ и _FCM_;
   - реализован сервис локальных уведомлений;
   - добавлена авторизация через VK ID SDK;
   - внедрены Live Activities для онлайн-матча.

![Torpedo integrations](assets/projects/torpedo/images/integrations.png)

## Решение
Реализована feature-first архитектура с явным разделением слоёв:
- ***presentation*** - страницы, виджеты, _BLoC_ / _Cubit_;
- ***domain*** - модели, контракты и use cases;
- ***data*** - репозитории, remote/local data source, DTO/мапперы;
- ***core*** - DI, роутинг, тема, сеть, логирование, платформенные сервисы.
Ключевые технические решения:
- единая модульная схема для независимого развития feature-команд;
- централизованный DI через _get_it_ + _injectable_;

![Torpedo interceptors](assets/projects/torpedo/images/interceptors.png)

- nested-навигация на _auto_route_ для сложных переходов;
- сеть на _Dio_ с интерсепторами авторизации и ошибок;
- локальные данные через _Drift_ / _SharedPreferences_;
- observability через _talker_, _FirebaseAnalyticsObserver_, _Crashlytics_;
- i18n через _slang_ и системную локаль в рантайме.

## Детальная структура модулей
- **Core**
  - DI (_get_it_, _injectable_), тема, router, network/interceptors, logger, platform services.
- **Data**
  - remote data source и API-DTO;
  - local DB/DAO (_drift_) и локальные таблицы;
  - репозитории и мапперы доменных моделей.
- **Domain**
  - сущности и value-объекты;
  - интерфейсы репозиториев;
  - use cases для auth, user data, notifications, match online.

![Torpedo notify](assets/projects/torpedo/images/notify.png)

- **Presentation**
  - feature pages/wrappers (main, season, tickets, more, in_arena);
  - _BLoC_ / _Cubit_ для экранной логики;
  - переиспользуемые UI-компоненты и app-widgets.

## Platform-specific интеграции (детально)
В проекте есть осознанное использование платформенных возможностей для user-facing сценариев.

#### 1. Firebase Messaging + Local Notifications
Назначение: стабильная доставка уведомлений и контролируемый UX при разных состояниях приложения.
- Сервисы: _FirebaseMessageServices_, _LocalNotificationsService_
- Сценарии:
  - получение и обновление _FCM_ token;
  - запрос/удаление разрешений на push;
  - обработка foreground/background push-сообщений;
  - локальный показ уведомлений с payload-данными.

![Torpedo FMC](assets/projects/torpedo/images/fmc.png)

#### 2. Live Activities (онлайн-матч)
Назначение: real-time отображение ключевого статуса матча вне приложения.
- Сервис: LiveActivityOnlineMatchService
- Плагин: _live_activities_
- Сценарии:
  - инициализация активности и создание/обновление/завершение;
  - обработка логотипов команд для iOS/Android (base64/локальные файлы);
  - устойчивый lifecycle активности в матчевом потоке.

![Torpedo live activities](assets/projects/torpedo/images/live_activities.png)

![Torpedo live activities init](assets/projects/torpedo/images/live_activities_init.png)

![Torpedo live activities init](assets/projects/torpedo/images/entitlements.png)

#### 3. VK ID SDK
Назначение: нативный и привычный способ авторизации для целевой аудитории приложения.
- Сервис: VkAuthService
- Плагин: _vkid_flutter_sdk_
- Сценарии:
  - единая точка инициализации VKID;
  - интеграция в auth-flow;
  - логирование и контроль состояния SDK.

![Torpedo vk](assets/projects/torpedo/images/vk.png)

## Что реализовано по функционалу
- Главный экран, stories, календарные/сезонные блоки и турнирная таблица.
- Матч-центр: future/current/past матчи, обзор и контентные блоки матча.
- Новости и медиа-раздел (фото, видео, webview-контент).
- Билеты и пользовательские тикеты, включая страницы деталей.
- Профиль пользователя, настройки и управление уведомлениями.
- In-arena блок: QR, заказы, каталог и навигация по арене.
- Loyalty program, bonus history, shop и дополнительные клубные сервисы.

## Результаты
- Сформирована production-oriented платформа fan-приложения с широким feature-набором.
- В одном приложении объединены контент, матчевые сценарии, tickets и in-arena сервисы.
- Повышена стабильность эксплуатации за счёт системного логирования и crash-репортинга.
- Реализована сквозная push-инфраструктура с контролем permissions/token flow.
- Подготовлена архитектурная база для масштабирования модулей и командной разработки.

## Технический стек (детально)
- **Flutter/Dart**
  - Flutter SDK
  - Dart SDK _^3.6.0_
- **State management**
  - _flutter_bloc_, _equatable_
- **Dependency injection**
  - _get_it_, _injectable_
- **Routing**
  - _auto_route_
- **Networking**
  - _dio_ + custom interceptors
- **Data layer**
  - _drift_, _sqlite3_flutter_libs_, _shared_preferences_
- **Integrations**
  - _firebase_core_, _firebase_analytics_, _firebase_crashlytics_, _firebase_messaging_
  - _flutter_local_notifications_, _vkid_flutter_sdk_, _live_activities_
- **Media/UI**
  - _youtube_player_flutter_, _vk_video_, _webview_flutter_, _flutter_html_, _lottie_
- **Localization/codegen**
  - _slang_, _slang_flutter_, _build_runner_, _freezed_

## Роль и зона ответственности
Полный цикл Flutter-разработки в проекте:
- проектирование и развитие модульной архитектуры;
- реализация feature-модулей и пользовательских сценариев;
- интеграция Firebase, VK ID и Live Activities;
- развитие навигации, DI и сетевого слоя;
- поддержка качества через логирование, observability и техническую стабилизацию.

## Ограничения и технические нюансы
- Большое количество feature-модулей требует строгой дисциплины в границах слоёв и зависимостях.
- Часть сценариев (push/background/live activity) чувствительна к платформенным ограничениям iOS/Android.
- Реальная валидация продуктовых сценариев требует тестов на физических устройствах и в матчевые дни.

## Дальнейшие шаги
- Усиление automated tests (unit/widget/integration) для критических пользовательских потоков.
- Формализация CI quality gates для ключевых веток и релизных сборок.
- Расширение мониторинга бизнес-событий и продуктовой аналитики.
- Подготовка публичного case-описания и визуальных артефактов проекта.
