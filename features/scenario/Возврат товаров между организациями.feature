﻿#language: ru

@tree

Функционал: Возврат товаров между организациями

Как Тестировщик я хочу
создать Возврат товаров между организациями
чтобы использовать его в дымовом тесте

Контекст:
	И я подключаю TestClient "Этот клиент" логин "eremin" пароль "Tb4m8443df"
	И Я закрыл все окна клиентского приложения

Сценарий: Закрыть окно о копии базы
	Если открылось окно 'Информационная база была перемещена или восстановлена из резервной копии' Тогда
		И я нажимаю на кнопку с именем 'ЭтоКопияИнформационнойБазы'

Сценарий: Создание Возврата товаров между организациями

	* Находим склад для возврата
		И я выполняю код встроенного языка на сервере
		"""bsl
			Объект.ЗначениеНаСервере = НЕОПРЕДЕЛЕНО;
			Запрос = Новый Запрос (
			"ВЫБРАТЬ ПЕРВЫЕ 1
			|	СвободныеОстаткиОстатки.Номенклатура КАК Номенклатура,
			|	СвободныеОстаткиОстатки.Склад КАК Склад,
			|	СвободныеОстаткиОстатки.ВНаличииОстаток КАК ВНаличииОстаток
			|ИЗ
			|	РегистрНакопления.СвободныеОстатки.Остатки КАК СвободныеОстаткиОстатки
			|ГДЕ
			|	СвободныеОстаткиОстатки.ВНаличииОстаток > 1");
			ВыборкаЗапроса = Запрос.Выполнить().Выбрать();
			Если ВыборкаЗапроса.Следующий() Тогда
				Объект.ЗначениеНаСервере = ВыборкаЗапроса.Склад;
			КонецЕсли;
		"""
		И Я запоминаю значение выражения 'Объект.ЗначениеНаСервере' в переменную "СкладДляВозврата"

	* Находим товар для возврата
		И я выполняю код встроенного языка на сервере
		"""bsl
			Объект.ЗначениеНаСервере = НЕОПРЕДЕЛЕНО;
			Запрос = Новый Запрос (
			"ВЫБРАТЬ ПЕРВЫЕ 1
			|	СвободныеОстаткиОстатки.Номенклатура КАК Номенклатура,
			|	СвободныеОстаткиОстатки.Склад КАК Склад,
			|	СвободныеОстаткиОстатки.ВНаличииОстаток КАК ВНаличииОстаток
			|ИЗ
			|	РегистрНакопления.СвободныеОстатки.Остатки КАК СвободныеОстаткиОстатки
			|ГДЕ
			|	СвободныеОстаткиОстатки.ВНаличииОстаток > 1");
			ВыборкаЗапроса = Запрос.Выполнить().Выбрать();
			Если ВыборкаЗапроса.Следующий() Тогда
				Объект.ЗначениеНаСервере = ВыборкаЗапроса.Номенклатура;
			КонецЕсли;
		"""
		И Я запоминаю значение выражения 'Объект.ЗначениеНаСервере' в переменную "ТоварДляВозврата"

	* Создание документа
		И Я открываю навигационную ссылку "e1cib/list/Документ.ВозвратТоваровМеждуОрганизациями"
		Когда открылось окно "Возвраты товаров между организациями"
		И я нажимаю на кнопку с именем 'ФормаСоздать'
		Тогда открылось окно "Возврат товаров между организациями (создание)"
		Если элемент формы с именем 'Организация' стал равен "ФИТПЛЕЙС" тогда
			И пауза 1
		Иначе
			И из выпадающего списка с именем 'Организация' я выбираю точное значение "ФИТПЛЕЙС"

		Если элемент формы с именем 'ОрганизацияПолучатель' стал равен "ФИТАТЛОН" тогда
			И пауза 1
		Иначе 
			И из выпадающего списка с именем 'ОрганизацияПолучатель' я выбираю точное значение "ФИТАТЛОН"

	* Заполнение шапки документа
		И я нажимаю кнопку выбора у поля с именем 'Склад'
		Тогда открылось окно "Склады и магазины"
		И в таблице 'Список' я перехожу к строке:
			| "Наименование"         |
			| "$СкладДляВозврата$"   |
		И я нажимаю на кнопку с именем 'ФормаВыбрать'

	* Добавление товара для возврата
		И я перехожу к закладке с именем 'СтраницаТовары'
		И в таблице 'Товары' я нажимаю на кнопку с именем 'ТоварыДобавить'
		И в таблице 'Товары' в поле с именем 'ТоварыНоменклатура' я ввожу текст "$ТоварДляВозврата$"
		И в таблице 'Товары' в поле с именем 'ТоварыКоличествоУпаковок' я ввожу текст "1,000"
		И в таблице 'Товары' в поле с именем 'ТоварыЦена' я ввожу текст "10,00"

	* Провести и закрыть документ документа
		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
		И я жду закрытия окна "Возврат между организациями FPTR-000003 от *" в течение 20 секунд

Сценарий: Закрываем клиент тестирования
	И я закрываю все окна клиентского приложения
	И я закрываю главное окно TestClient
	Если появилось предупреждение в течение 10 секунд тогда
		И я нажимаю на кнопку с именем 'Button0'