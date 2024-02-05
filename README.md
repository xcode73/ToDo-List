Необходимо написать мобильное приложение, представляющее из себя
ежедневник
Функционал: В приложении присутствуют 2 экрана - Список дел с календарем,
подробное описание дела
Список дел должен быть в формате JSON
Пример:
{
“id”:1,
“date_start”:”147600000”,
“date_finish”:”147610000”,
“name”:”My task”,
“description”:”Описание моего дела”
} (date_start, date_finish имеют тип timestamp)
Список дел с календарем - экран на котором присутствует возможность
выбрать один день, после выбора дня в конце экрана должна обновиться
таблица с делами, в каждой ячейке таблицы указан 1 час из дня (например
14.00-15.00)
Если в это время есть дело, оно должно отобразиться блоком (название и
время)
Подробное описание дела включает в себя: название, дату и время, краткое
описание дела текстом
Критерии выполнения задания
1й уровень:
- Структурированный чистый код (желательно использовать Swiftlint)
- Использование сервисного слоя для подготовки данных
- UI должен быть написан с использованием Storyboard/Xib и Autolayout
- Использование архитектурных паттернов
- Поддержка версий - iOS 12+
- Поддержка платформ - iPhone
- Ориентация - портретная
- Код на GitHub
2й уровень:
- Добавить экран создания дела, на котором присутствует возможность указать
название, выбрать дату и время, краткое описание дела текстом
- Верстка как в IB, так и из кода, нативно или с использованием сторонних
библиотек (например: PinLayout, SnapKit)
- Для локального хранения используем Realm
- Использовать Cocoa Pods
- Покрытие Unit-тестами: 1-2 теста