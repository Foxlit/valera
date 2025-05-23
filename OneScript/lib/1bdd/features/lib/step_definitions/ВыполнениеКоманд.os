﻿// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd
#Использовать 1commands
#Использовать asserts

Перем БДД; //контекст фреймворка 1bdd
Перем Лог;

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯОчищаюПараметрыКомандыВКонтексте");
	ВсеШаги.Добавить("ЯВключаюОтладкуЛогаСИменем");
	ВсеШаги.Добавить("ЯВыключаюОтладкуЛогаСИменем");
	ВсеШаги.Добавить("ЯВыполняюКоманду");
	ВсеШаги.Добавить("ВыводКомандыСодержит");
	ВсеШаги.Добавить("КодВозвратаКомандыРавен");
	ВсеШаги.Добавить("ЯВыполняюКомандуСПараметрами");
	ВсеШаги.Добавить("ЯСообщаюВыводКоманды");
	ВсеШаги.Добавить("ЯДобавляюПараметрДляКоманды");
	ВсеШаги.Добавить("ВыводКомандыНеСодержит");
	ВсеШаги.Добавить("ЯПоказываюВыводКоманды");
	ВсеШаги.Добавить("ЯВижуВКонсолиВывод");
	ВсеШаги.Добавить("ЯНеВижуВКонсолиВывод");
	ВсеШаги.Добавить("ЯВижуВКонсолиСтрокуПодобно");
	ВсеШаги.Добавить("ЯНеВижуВКонсолиСтрокуПодобно");
	ВсеШаги.Добавить("КодВозвратаРавен");
	ВсеШаги.Добавить("ЯЗавершаюРаботуПриложения");

	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт
	
КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт
	
КонецПроцедуры

//Я очищаю параметры команды "git" в контексте
Процедура ЯОчищаюПараметрыКомандыВКонтексте(Знач ИмяКоманды) Экспорт
	Лог.Отладка("ЯОчищаюПараметрыКомандыВКонтексте Создаю команду ИмяКоманды %1", ИмяКоманды);

	КлючКонтекста = КлючКоманды(ИмяКоманды);
	Команда = Новый Команда;
	Команда.ПоказыватьВыводНемедленно(Ложь);
	Лог.Отладка("Устанавливаю признак немедленного показа вывода");

	Команда.УстановитьСтрокуЗапуска(ИмяКоманды);

	ДобавитьПараметрСтатистикиДляКомандыОСкрипт(Команда);

	БДД.СохранитьВКонтекст(КлючКонтекста, Команда);
	БДД.СохранитьВКонтекст(КлючПоследнейКоманды(), Команда);
КонецПроцедуры

//я включаю отладку лога с именем "bdd"
Процедура ЯВключаюОтладкуЛогаСИменем(Знач ИмяЛога) Экспорт
    НужныйЛог = Логирование.ПолучитьЛог(ИмяЛога);
	НужныйЛог.УстановитьУровень(УровниЛога.Отладка);
КонецПроцедуры

//я выключаю отладку лога с именем "bdd"
Процедура ЯВыключаюОтладкуЛогаСИменем(Знач ИмяЛога) Экспорт
    НужныйЛог = Логирование.ПолучитьЛог(ИмяЛога);
	НужныйЛог.УстановитьУровень(УровниЛога.Информация);
КонецПроцедуры

//Я выполняю команду "git"
Процедура ЯВыполняюКоманду(Знач ИмяИлиТекстКоманды) Экспорт
	Команда = ПолучитьКомандуИзКонтекста(ИмяИлиТекстКоманды);
	
	ВыполнитьКомандуСПредварительнойОбработкой(Команда);
	
КонецПроцедуры

//Я выполняю команду "git" с параметрами "--version"
Процедура ЯВыполняюКомандуСПараметрами(Знач ИмяКоманды, Знач ПараметрыКоманды) Экспорт
	Команда = ПолучитьКомандуИзКонтекста(ИмяКоманды);

	ПараметрыКоманды = ЗаменитьШаблоныВПараметрахКоманды(ПараметрыКоманды);
	Команда.УстановитьПараметры(ПараметрыКоманды);

	Лог.Отладка("Выполняю команду <%1> с параметрами <%2>", ИмяКоманды, ПараметрыКоманды);

	ВыполнитьКомандуСПредварительнойОбработкой(Команда);

КонецПроцедуры

//Я добавляю параметр "--version" для команды "git"
Процедура ЯДобавляюПараметрДляКоманды(Знач ПараметрКоманды, Знач ИмяКоманды) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));

	ПараметрКоманды = ЗаменитьШаблоныВПараметрахКоманды(ПараметрКоманды);
	Команда.ДобавитьПараметр(ПараметрКоманды);
КонецПроцедуры

//Вывод команды "oscript" содержит "[--version]"
Процедура ВыводКомандыСодержит(Знач ИмяКоманды, Знач ОжидаемыйВыводКомандыИлиТаблицаЗначений) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));
	
	ПроверитьВыводКомандыНаВхождение(Команда, ОжидаемыйВыводКомандыИлиТаблицаЗначений);
КонецПроцедуры

//Вывод команды "oscript" не содержит "КаталогПроекта"
Процедура ВыводКомандыНеСодержит(Знач ИмяКоманды, Знач ОжидаемыйВыводКомандыИлиТаблицаЗначений) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));
	
	ПроверитьВыводКомандыНаОтсутствие(Команда, ОжидаемыйВыводКомандыИлиТаблицаЗначений);
КонецПроцедуры

//Код возврата команды "git" равен 1
Процедура КодВозвратаКомандыРавен(Знач ИмяКоманды, Знач ОжидаемыйКодВозврата) Экспорт
	
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));

	Ожидаем.Что(Команда.ПолучитьКодВозврата(), "Код возврата").Равно(ОжидаемыйКодВозврата);
КонецПроцедуры

//Я сообщаю вывод команды "oscript"
Процедура ЯСообщаюВыводКоманды(Знач ИмяКоманды) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючКоманды(ИмяКоманды));
	
	ВыводКоманды = Команда.ПолучитьВывод();
	Сообщить(ВыводКоманды);
КонецПроцедуры

//я вижу в консоли вывод "лог команды"
Процедура ЯВижуВКонсолиВывод(Знач ОжидаемыйВыводКомандыИлиТаблицаЗначений) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючПоследнейКоманды());
	
	ПроверитьВыводКомандыНаВхождение(Команда, ОжидаемыйВыводКомандыИлиТаблицаЗначений);
КонецПроцедуры

//я не вижу в консоли вывод "Несуществующий вывод команды"
Процедура ЯНеВижуВКонсолиВывод(Знач ОжидаемыйВыводКомандыИлиТаблицаЗначений) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючПоследнейКоманды());
	
	ПроверитьВыводКомандыНаОтсутствие(Команда, ОжидаемыйВыводКомандыИлиТаблицаЗначений);
КонецПроцедуры

//я вижу в консоли строку подобно "(\d+\.){3}\d+"
Процедура ЯВижуВКонсолиСтрокуПодобно(Знач ШаблонРегулярки) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючПоследнейКоманды());
	
	ВыводКоманды = Команда.ПолучитьВывод();

	РегулярноеВыражение = Новый РегулярноеВыражение(ШаблонРегулярки);
	Сообщение = СтрШаблон("Ожидали, что найдем совпадение по регулярному выражению %1, а это не так.", ШаблонРегулярки);
	Ожидаем.Что(РегулярноеВыражение.Совпадает(ВыводКоманды), Сообщение).ЭтоИстина();
КонецПроцедуры

//я не вижу в консоли строку подобно "(\d+\.){5}"
Процедура ЯНеВижуВКонсолиСтрокуПодобно(Знач ШаблонРегулярки) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючПоследнейКоманды());
	
	ВыводКоманды = Команда.ПолучитьВывод();

	РегулярноеВыражение = Новый РегулярноеВыражение(ШаблонРегулярки);
	Сообщение = СтрШаблон("Ожидали, что не найдем совпадение по регулярному выражению %1, а оно найдено.", ШаблонРегулярки);
	Ожидаем.Что(РегулярноеВыражение.Совпадает(ВыводКоманды), Сообщение).ЭтоЛожь();
КонецПроцедуры

//Я показываю вывод команды
Процедура ЯПоказываюВыводКоманды() Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючПоследнейКоманды());
	
	ВыводКоманды = Команда.ПолучитьВывод();
	Сообщить(ВыводКоманды);
КонецПроцедуры

//Код возврата равен 0
Процедура КодВозвратаРавен(Знач ОжидаемыйКодВозврата) Экспорт
	Команда = БДД.ПолучитьИзКонтекста(КлючПоследнейКоманды());

	Ожидаем.Что(Команда.ПолучитьКодВозврата(), "Код возврата").Равно(ОжидаемыйКодВозврата);
КонецПроцедуры

//я завершаю работу приложения "crserver"
Процедура ЯЗавершаюРаботуПриложения(Знач ИмяИсполняемогоФайла) Экспорт
	УбитьПриложение(ИмяИсполняемогоФайла);
КонецПроцедуры

// { Служебные функции
Функция ПолучитьКомандуИзКонтекста(Знач ИмяКоманды)
	КлючКонтекста = КлючКоманды(ИмяКоманды);
	Лог.Отладка("ПолучитьКомандуИзКонтекста Имя команды %1", ИмяКоманды);
	Лог.Отладка("ПолучитьКомандуИзКонтекста КлючКонтекста %1", КлючКонтекста);

	Команда = БДД.ПолучитьИзКонтекста(КлючКонтекста);

	Если Не ЗначениеЗаполнено(Команда) Тогда
		ЯОчищаюПараметрыКомандыВКонтексте(ИмяКоманды);
		Команда = БДД.ПолучитьИзКонтекста(КлючКонтекста);
	КонецЕсли;

	ДобавитьПараметрСтатистикиДляКомандыОСкрипт(Команда);
	
	Возврат Команда;
КонецФункции

Процедура ПроверитьВыводКомандыНаВхождение(Знач Команда, Знач ОжидаемыйВыводКомандыИлиТаблицаЗначений)
	ВыводКоманды = Команда.ПолучитьВывод();
	ВыводКоманды = ЗаменитьШаблоныВПараметрахКоманды(ВыводКоманды);

	ТипПараметра = ТипЗнч(ОжидаемыйВыводКомандыИлиТаблицаЗначений);
	Если ТипПараметра = Тип("Строка") Тогда
		ОжидаемыйВыводКомандыИлиТаблицаЗначений = ЗаменитьШаблоныВПараметрахКоманды(ОжидаемыйВыводКомандыИлиТаблицаЗначений);

		Ожидаем.Что(ВыводКоманды).Содержит(ОжидаемыйВыводКомандыИлиТаблицаЗначений);

	ИначеЕсли ТипПараметра = Тип("ТаблицаЗначений") Тогда
		ПроверитьСтрокуНаВхождениеПодстрокИзТаблицы(ВыводКоманды, ОжидаемыйВыводКомандыИлиТаблицаЗначений);
	КонецЕсли;
КонецПроцедуры

Процедура ПроверитьВыводКомандыНаОтсутствие(Знач Команда, Знач ОжидаемыйВыводКомандыИлиТаблицаЗначений)
	ВыводКоманды = Команда.ПолучитьВывод();
	ВыводКоманды = ЗаменитьШаблоныВПараметрахКоманды(ВыводКоманды);

	ТипПараметра = ТипЗнч(ОжидаемыйВыводКомандыИлиТаблицаЗначений);
	Если ТипПараметра = Тип("Строка") Тогда
		ОжидаемыйВыводКомандыИлиТаблицаЗначений = ЗаменитьШаблоныВПараметрахКоманды(ОжидаемыйВыводКомандыИлиТаблицаЗначений);

		Ожидаем.Что(ВыводКоманды).Не_().Содержит(ОжидаемыйВыводКомандыИлиТаблицаЗначений);

	ИначеЕсли ТипПараметра = Тип("ТаблицаЗначений") Тогда
		ПроверитьСтрокуНаОтсутствиеПодстрокИзТаблицы(ВыводКоманды, ОжидаемыйВыводКомандыИлиТаблицаЗначений);
	КонецЕсли;
КонецПроцедуры

// TODO перенести в библиотеку asserts
Процедура ПроверитьСтрокуНаВхождениеПодстрокИзТаблицы(Знач СтрокаГдеИщем, Знач ТаблицаИскомыхПодстрок)
	СтрокаРасхождений = "";
	Для каждого ЧтоИщем Из ТаблицаИскомыхПодстрок Цикл
		СтрокаЧтоИщем = ЧтоИщем[0];
		СтрокаЧтоИщем = ЗаменитьШаблоныВПараметрахКоманды(СтрокаЧтоИщем);

		Если Найти(СтрокаГдеИщем, СтрокаЧтоИщем) = 0 Тогда
			СтрокаРасхождений = СтрШаблон("%1%3    Не найдена подстрока <%2>", СтрокаРасхождений, СтрокаЧтоИщем, 
				Символы.ПС);
		КонецЕсли;
	КонецЦикла;
	Если Не ПустаяСтрока(СтрокаРасхождений) Тогда
		СтрокаРасхождений = СтрШаблон("Не нашли одну из подстрок таблицы:%3%2%3 в строке:%3%1 ", 
			СтрокаГдеИщем, СтрокаРасхождений, Символы.ПС);
		Ожидаем.Что(Истина, СтрокаРасхождений).ЭтоЛожь();
	КонецЕсли;
КонецПроцедуры

// TODO перенести в библиотеку asserts
Процедура ПроверитьСтрокуНаОтсутствиеПодстрокИзТаблицы(Знач СтрокаГдеИщем, Знач ТаблицаИскомыхПодстрок)
	СтрокаРасхождений = "";
	Для каждого ЧтоИщем Из ТаблицаИскомыхПодстрок Цикл
		СтрокаЧтоИщем = ЧтоИщем[0];
		СтрокаЧтоИщем = ЗаменитьШаблоныВПараметрахКоманды(СтрокаЧтоИщем);

		Если Найти(СтрокаГдеИщем, СтрокаЧтоИщем) <> 0 Тогда
			СтрокаРасхождений = СтрШаблон("%1%3    Найдена подстрока <%2>", СтрокаРасхождений, СтрокаЧтоИщем, 
				Символы.ПС);
		КонецЕсли;
	КонецЦикла;
	Если Не ПустаяСтрока(СтрокаРасхождений) Тогда
		СтрокаРасхождений = 
			СтрШаблон("Ожидали, что не найдем одну из подстрок таблицы, но одна из них найдена:%3%2%3 Строка, где искали:%3%1", 
				СтрокаГдеИщем, СтрокаРасхождений, Символы.ПС);
		Ожидаем.Что(Истина, СтрокаРасхождений).ЭтоЛожь();
	КонецЕсли;
КонецПроцедуры

Функция КлючКоманды(Знач ИмяКоманды)
	Возврат "Команда-" + ИмяКоманды;
КонецФункции

Функция КлючПоследнейКоманды()
	Возврат "ПоследняяКоманда";
КонецФункции

Функция ЗаменитьШаблоныВПараметрахКоманды(Знач ПараметрыКоманды)
	Рез = СтрЗаменить(ПараметрыКоманды, "<КаталогПроекта>", БДД.КаталогПроверяемогоПроекта());
	Рез = СтрЗаменить(Рез, "<РабочийКаталог>", БДД.ПолучитьИзКонтекста("РабочийКаталог"));
	Возврат Рез;
КонецФункции

Процедура ВыполнитьКомандуСПредварительнойОбработкой(Знач Команда)
	ДобавитьПараметрСтатистикиДляКомандыОСкрипт(Команда);

	Команда.Исполнить();
КонецПроцедуры

Процедура ДобавитьПараметрСтатистикиДляКомандыОСкрипт(Команда)
	Если Не ЭтоКомандаОСкрипт(Команда) Тогда
		Возврат;
	КонецЕсли;
	КомандаСтатистики = "-codestat";
	Если ЗаданПараметрСтатистикиДляКомандыОСкрипт(Команда, КомандаСтатистики) Тогда
		Возврат;
	КонецЕсли;

	ОбъектКаталогаСтатистики = БДД.ПолучитьИзКонтекста("ПризнакСтатистикиСкриптовOnescript");
	Если ЗначениеЗаполнено(ОбъектКаталогаСтатистики) Тогда
		Ожидаем.Что(ОбъектКаталогаСтатистики.Существует(), 
			"Каталог статистики должен существовать перед выполнения скрипта OneScript").Равно(Истина);

		МенеджерВременныхФайлов = Новый МенеджерВременныхФайлов;
		МенеджерВременныхФайлов.БазовыйКаталог = ОбъектКаталогаСтатистики.ПолноеИмя;
		ИмяФайлаСтатистики = МенеджерВременныхФайлов.НовоеИмяФайла("json");
		ПутьФайлаСтатистики = ОбъединитьПути(ОбъектКаталогаСтатистики.ПолноеИмя, ИмяФайлаСтатистики);
		
		НовыеПараметры = Команда.ПолучитьПараметры();
		НовыеПараметры.Вставить(0, СтрШаблон("%1=%2", КомандаСтатистики, ПутьФайлаСтатистики));
	КонецЕсли;
КонецПроцедуры

Функция ЭтоКомандаОСкрипт(Знач Команда)
	СТРОКА_OSCRIPT = "oscript";
	ПутьПриложения = СокрЛП(Команда.ПолучитьКоманду());
	ЗапускаемСкриптОСкрипт = Ложь;
	Если НРег(ПутьПриложения) = СТРОКА_OSCRIPT Тогда
		ЗапускаемСкриптОСкрипт = Истина;
	Иначе
		Если Найти(НРег(ПутьПриложения), СТРОКА_OSCRIPT) = 1 Тогда
			ЗапускаемСкриптОСкрипт = Истина;
		Иначе
			ФайлПриложения = Новый Файл(ПутьПриложения);
			Если НРег(ФайлПриложения.ИмяБезРасширения) = СТРОКА_OSCRIPT Тогда
				ЗапускаемСкриптОСкрипт = Истина;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	Возврат ЗапускаемСкриптОСкрипт;
КонецФункции // ЭтоКомандаОСкрипт()

Функция ЗаданПараметрСтатистикиДляКомандыОСкрипт(Знач Команда, Знач КомандаСтатистики)
	КомандаСтатистики = НРег(КомандаСтатистики);
	Параметры = Команда.ПолучитьПараметры();
	Для каждого Параметр Из Параметры Цикл
		Если Найти(НРег(Параметр), КомандаСтатистики) > 0 Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	Возврат Ложь;
КонецФункции // ЗаданПараметрСтатистикиДляКомандыОСкрипт()

Процедура УбитьПриложение(Знач ИмяИсполняемогоФайла) Экспорт
	
	Перем ЭтоWindows;

	СистемнаяИнформация = Новый СистемнаяИнформация;
	ЭтоWindows = Найти(ВРег(СистемнаяИнформация.ВерсияОС), "WINDOWS") > 0;

	Если ЭтоWindows Тогда
		СтрокаКоманды = "TASKKILL /F /IM %1";
	Иначе
		СтрокаКоманды = "pkill %1";
	КонецЕсли;
	СтрокаКоманды = СтрШаблон(СтрокаКоманды, ИмяИсполняемогоФайла);
	КодВозврата = -1;
	ЗапуститьПриложение(СтрокаКоманды, , Истина, КодВозврата);
КонецПроцедуры

//}

Лог = Логирование.ПолучитьЛог("bdd");
