# GitHub User's List App

Тестовое задание на Flutter. Приложение показывает список пользователей GitHub и их профили.

## Что делает приложение

- **Splash** — логотип на 3 секунды, затем переход на главный экран. Есть нативный splash для Android и iOS (`flutter_native_splash`).
- **UsersList** — главный экран. Список пользователей из [GitHub Users API](https://docs.github.com/en/rest/users/users), пагинация при прокрутке, поиск по логину. Тап по пользователю открывает профиль.
- **UserDetail** — дополнительная информация о пользователе, кнопка «назад». Можно перейти к списку репозиториев.

Дополнительно: экран **Settings** (выбор языка), уведомления при потере/восстановлении интернета.

## Требования ТЗ

| Требование | Статус |
|------------|--------|
| Flutter + архитектура | ✅ feature-first, BLoC (Cubit), Repository |
| Splash 3 сек | ✅ |
| UsersList + GitHub API | ✅ |
| UserDetail + кнопка назад | ✅ |
| BLoC | ✅ `flutter_bloc` |
| Пагинация | ✅ список пользователей и репозиториев |
| Нет интернета — уведомление | ✅ Snackbar через `connectivity_plus` |
| RU / EN, язык системы, fallback EN | ✅ `flutter_localizations` + настройки |
| Только портретная ориентация | ✅ |

## Стек

Flutter, `flutter_bloc`, `dio`, `connectivity_plus`, `shared_preferences`, `flutter_native_splash`.

API: `https://api.github.com`

## Структура

```
lib/
├── main.dart
├── core/          # роутинг, тема, утилиты
├── features/      # users_list, user_detail, repos_list, settings
├── network/       # dio, connectivity
├── source/        # модели, repository
├── components/    # общие виджеты
└── l10n/          # ru / en
```

## Запуск

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Тесты:

```bash
flutter test
```
