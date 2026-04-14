/// Single place for user-facing strings. Kept non-const-instance so future
/// i18n (slang / gen_l10n) can replace it without ripple changes.
class AppStrings {
  AppStrings._();

  // Brand ---------------------------------------------------------------------
  static const String authorName = 'Sergei Semenov';
  static const String authorRole = 'Senior Flutter Developer';
  static const String brandShort = 'SS';

  // Navigation ----------------------------------------------------------------
  static const String navProjects = 'Проекты';
  static const String navHome = 'Главная';

  // Hero ----------------------------------------------------------------------
  static const String availabilityBadge = 'Открыт к новым проектам';
  static const String heroTitleLine1 = 'Создаю кроссплатформенные';
  static const String heroTitleLine2 = 'приложения на Flutter';
  static const String heroSubtitle =
      'Мобильные, веб- и десктоп-продукты с чистой архитектурой, '
      'глубокой нативной интеграцией и вниманием к UX.';
  static const String ctaProjects = 'Смотреть проекты';
  static const String ctaContact = 'Связаться';

  // Sections ------------------------------------------------------------------
  static const String sectionAbout = 'Обо мне';
  static const String sectionSkills = 'Экспертиза';
  static const String sectionProjects = 'Проекты';
  static const String sectionContact = 'Контакты';

  // About ---------------------------------------------------------------------
  static const String aboutTitle = 'Flutter Developer с фокусом на качество';
  static const String aboutBody =
      'Проектирую архитектуру с нуля и довожу продукты до production. '
      'Работал с BLE/IoT, offline-first сценариями, платформенными каналами '
      'и CI/CD. Предпочитаю Clean Architecture, feature-first структуру, '
      'BLoC и осознанные компромиссы вместо модных трендов.';

  // Skills --------------------------------------------------------------------
  static const String skillsSubtitle =
      'Технологии, с которыми работаю в production-проектах.';

  // Projects ------------------------------------------------------------------
  static const String projectsIntro =
      'Избранные проекты — с описанием задач, решений и технических деталей.';
  static const String seeAllProjects = 'Все проекты';
  static const String backToProjects = 'К списку проектов';
  static const String noProjects = 'Проекты пока не добавлены';
  static const String loadingError = 'Не удалось загрузить проекты';

  // Contact -------------------------------------------------------------------
  static const String contactTitle = 'Готов к новым задачам';
  static const String contactBody =
      'Открыт для обсуждения интересных проектов, консалтинга '
      'и долгосрочного сотрудничества.';

  // TODO: fill in real contacts
  static const String contactEmail = 'hello@example.com';
  static const String contactGithub = 'https://github.com/SergeiSMV';
  static const String contactTelegram = 'https://t.me/';
  static const String contactLinkedIn = 'https://www.linkedin.com/in/';
}
