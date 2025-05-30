﻿#language: ru

@tree

Функционал: Заявка на расход ДС

Как Тестировщик я хочу
создать заявку на расход ДС
чтобы проверить работоспособности данной функции

Сценарий: выключение уведомлений
И Я устанавливаю в константу "CRM_ИспользоватьНапоминания" значение "ЛОЖЬ"

Сценарий: сброс пароля пользователя
	И я выполняю код встроенного языка на сервере
	"""bsl
		УстановитьПривилегированныйРежим(Истина);
		МойПользователь = ПользователиИнформационнойБазы.НайтиПоИмени("БорисовС");
		МойПользователь.Пароль = "123321";
		МойПользователь.Записать();
	"""
	И я подключаю TestClient "Этот клиент" логин "БорисовС" пароль "123321"

Сценарий: Закрыть окно о копии базы
	Если открылось окно 'Информационная база была перемещена или восстановлена из резервной копии' Тогда
		И я нажимаю на кнопку с именем 'ЭтоКопияИнформационнойБазы'

Сценарий: Настройка лицензий БИТ
	Когда Лицензия БИТ.ФИНАНС.УТ

Сценарий: Формирование заявки на расход ДС
* Закрытие всех окон клиента
	И я закрываю все окна клиентского приложения

* Открытие списка заявок на расход ДС
	И В командном интерфейсе я выбираю "Казначейство" "Списания безналичных ДС"
	Тогда открылось окно "Списания безналичных денежных средств"

* Создание заявки на расход ДС
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Тогда открылось окно "Списание безналичных денежных средств (создание)"

* Заполнение шапки документа
	И я нажимаю кнопку выбора у поля с именем 'БанковскийСчет'
	Тогда открылось окно "Банковские счета"
	И в таблице 'Список' я перехожу к строке:
		| "Наименование"        |
		| "ФИТАТЛОН (RUB) ВТБ " |
	И я нажимаю на кнопку с именем 'ФормаВыбрать'

	И я нажимаю кнопку выбора у поля с именем 'Контрагент'
	Тогда открылось окно "Контрагенты (юридические или физические лица)"
	И в таблице 'Список' я активизирую дополнение формы с именем 'СписокСтрокаПоиска'
	И в таблице 'Список' в дополнение формы с именем 'СписокСтрокаПоиска' я ввожу текст "КвадраСТройИнвест"
	И в таблице 'Список' я перехожу к строке:
		| 'Наименование'                               |
		| '<b><colorstyle -46>КвадраСтройИнвест</></>' |
	И я нажимаю на кнопку с именем 'ФормаВыбрать'

	И я нажимаю кнопку выбора у поля с именем 'СтатьяДДС_БУ'
	Тогда открылось окно "Статьи ДДС БУ"
	И в таблице 'Список' я перехожу к строке:
		| "Код"       | "Наименование" |
		| "000000113" | "З/П"          |
	И я нажимаю на кнопку с именем 'ФормаВыбрать'
	И в поле с именем 'СуммаДокумента' я ввожу текст "10,00"
	И я нажимаю на кнопку с именем 'ЗаполнитьНазначениеПлатежа'
	И я нажимаю кнопку выбора у поля с именем 'Подразделение'
	Тогда открылось окно "Структура предприятия"
	И в таблице 'Список' я перехожу к строке:
		| "Код"       | "Наименование" |
		| "TR-000015" | "IT"           |
	И я нажимаю на кнопку с именем 'ФормаВыбрать'
	И я активизирую поле с именем "ВидПлатежа"
	И я нажимаю сочетание клавиш "F4"
	//^^^Открытие выпадающего списка ВидПлатежа
	И из выпадающего списка с именем 'ВидПлатежа' я выбираю точное значение "Срочно"
	И в поле с именем 'ИдентификаторПлатежа' я ввожу текст "123321"
	И я нажимаю на кнопку с именем 'ЗаполнитьНазначениеПлатежа'

	* Заполнение СтраницаРасшифровка
		И я перехожу к закладке с именем 'СтраницаРасшифровка'
		И я нажимаю кнопку выбора у поля с именем 'РасшифровкаБезРазбиенияСтатьяДвиженияДенежныхСредств'
		Тогда открылось окно "Выбор статьи ДДС для операции \"Оплата поставщику\""
		И в таблице 'СписокПоХозяйственнойОперации' я перехожу к строке:
			| "Статья ДДС"                              |
			| "Внутреннее перемещение денежных средств" |
		И в таблице 'СписокПоХозяйственнойОперации' я нажимаю на кнопку с именем 'СписокПоХозяйственнойОперацииВыбрать'
		Тогда открылось окно "Списание безналичных денежных средств (создание) *"
		И я нажимаю кнопку выбора у поля с именем 'РасшифровкаБезРазбиенияСтатьяДДС_БУ'
		Тогда открылось окно "Статьи ДДС БУ"
		И в таблице 'Список' я перехожу к строке:
			| "Код"       | "Наименование" |
			| "000000113" | "З/П"          |
		И я нажимаю на кнопку с именем 'ФормаВыбрать'
	И я нажимаю на кнопку с именем 'ФормаЗаписать'
	И пауза 3
	
* Переменные НомерЗаявкиДС и ДатаЗаявкиДС
	И я запоминаю значение поля с именем "Номер" как "НомерЗаявкиДС"
	И я запоминаю значение поля с именем "Дата" как "ДатаДокументаСВременем"
	И Я запоминаю значение выражения 'Формат(Дата(Контекст.ДатаДокументаСВременем), "ДФ=\'dd.MM.yyyy\'")' в переменную "ДатаЗаявкиДС"
	И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
	И я жду закрытия окна "Заявка на расходование средств $НомерЗаявкиДС$ от *" в течение 20 секунд
	Если появилось предупреждение, тогда
		И я вызываю исключение с текстом сообщения "Не удалось провести заявку на расход ДС"

* Проверка наличия заявки в общем списке
	Тогда открылось окно "Списания безналичных денежных средств"
	И в таблице 'Список' я нажимаю на кнопку с именем 'СписокНайти'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Номер"
	И в поле с именем 'Pattern' я ввожу текст "$НомерЗаявкиДС$"
	И я нажимаю на кнопку с именем 'Find'

	И в таблице 'Список' я нажимаю на кнопку с именем 'СписокНайти'
	И из выпадающего списка с именем 'FieldSelector' я выбираю точное значение "Дата"
	И в поле с именем 'Pattern' я ввожу текст "$ДатаЗаявкиДС$"
	И я нажимаю на кнопку с именем 'Find'
	Тогда таблица 'Список' содержит строки:
		| 'Номер'           |
		| '$НомерЗаявкиДС$' |

Сценарий: Закрываем клиент тестирования
	И я закрываю все окна клиентского приложения
	И я закрываю главное окно TestClient
	Если появилось предупреждение в течение 10 секунд тогда
		И я нажимаю на кнопку с именем 'Button0'