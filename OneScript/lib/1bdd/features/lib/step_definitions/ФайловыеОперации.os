﻿// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd
#Использовать asserts
#Использовать fs
#Использовать logos

Перем БДД; //контекст фреймворка 1bdd
Перем Лог;

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯСоздаюВременныйКаталогИСохраняюЕгоВКонтекст");
	ВсеШаги.Добавить("ЯУстанавливаюВременныйКаталогКакРабочийКаталог");
	ВсеШаги.Добавить("ЯСоздаюКаталогВРабочемКаталоге");
	ВсеШаги.Добавить("ЯСоздаюКаталогВПодкаталогеРабочегоКаталога");
	ВсеШаги.Добавить("ВРабочемКаталогеСуществуетКаталог");
	ВсеШаги.Добавить("ВПодкаталогеРабочегоКаталогаСуществуетКаталог");
	ВсеШаги.Добавить("ЯСоздаюФайлВРабочемКаталоге");
	ВсеШаги.Добавить("ЯСоздаюФайлВПодкаталогеРабочегоКаталога");
	ВсеШаги.Добавить("ВРабочемКаталогеСуществуетФайл");
	ВсеШаги.Добавить("ВПодкаталогеРабочегоКаталогаСуществуетФайл");
	ВсеШаги.Добавить("ЯКопируюФайлИзКаталогаПроектаВРабочийКаталог");
	ВсеШаги.Добавить("ЯКопируюФайлИзКаталогаПроектаВПодкаталогРабочегоКаталога");
	ВсеШаги.Добавить("ЯКопируюКаталогИзКаталогаПроектаВРабочийКаталог");
	ВсеШаги.Добавить("ЯКопируюКаталогИзКаталогаПроектаВПодкаталогРабочегоКаталога");
	ВсеШаги.Добавить("ЯУстановилРабочийКаталогКакТекущийКаталог");
	ВсеШаги.Добавить("ЯУстановилПодкаталогРабочегоКаталогаКакТекущийКаталог");
	ВсеШаги.Добавить("КаталогСуществует");
	ВсеШаги.Добавить("КаталогНеСуществует");
	ВсеШаги.Добавить("ФайлСуществует");
	ВсеШаги.Добавить("ФайлНеСуществует");
	ВсеШаги.Добавить("ЯВосстановилПредыдущийКаталог");
	ВсеШаги.Добавить("ЯСохраняюКаталогПроектаВКонтекст");
	ВсеШаги.Добавить("ЯПоказываюКаталогПроекта");
	ВсеШаги.Добавить("ЯПоказываюРабочийКаталог");
	ВсеШаги.Добавить("ЯПоказываюТекущийКаталог");
	ВсеШаги.Добавить("ФайлВРабочемКаталогеСодержит");
	ВсеШаги.Добавить("ФайлВРабочемКаталогеНеСодержит");
	ВсеШаги.Добавить("ФайлСодержит");
	ВсеШаги.Добавить("ФайлНеСодержит");
	ВсеШаги.Добавить("ЯУдаляюФайл");

	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт
КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт
КонецПроцедуры

//Я создаю временный каталог и сохраняю его в контекст
Процедура ЯСоздаюВременныйКаталогИСохраняюЕгоВКонтекст() Экспорт
	ВременныйКаталог = ВременныеФайлы.СоздатьКаталог();
	БДД.СохранитьВКонтекст("ВременныйКаталог", ВременныйКаталог);
КонецПроцедуры

//Я устанавливаю временный каталог как рабочий каталог
Процедура ЯУстанавливаюВременныйКаталогКакРабочийКаталог() Экспорт
	БДД.СохранитьВКонтекст("РабочийКаталог", БДД.ПолучитьИзКонтекста("ВременныйКаталог"));
КонецПроцедуры

//Я создаю каталог "folder0" в рабочем каталоге
Процедура ЯСоздаюКаталогВРабочемКаталоге(Знач ПутьНовогоКаталога) Экспорт
	НовыйПуть = ОбъединитьПути(РабочийКаталог(), ПутьНовогоКаталога);
	СоздатьКаталог(НовыйПуть);
КонецПроцедуры

//Я создаю каталог "folder02" в подкаталоге "folder0" рабочего каталога
Процедура ЯСоздаюКаталогВПодкаталогеРабочегоКаталога(Знач ПутьНовогоКаталога, Знач ПутьКаталога) Экспорт
	НовыйПуть = ОбъединитьПути(РабочийКаталог(), ПутьКаталога, ПутьНовогоКаталога);
	СоздатьКаталог(НовыйПуть);
КонецПроцедуры

//Я создаю файл "file0.txt" в рабочем каталоге
Процедура ЯСоздаюФайлВРабочемКаталоге(Знач ПутьФайла) Экспорт
	НовыйПуть = ОбъединитьПути(РабочийКаталог(), ПутьФайла);
	СоздатьФайлПример(НовыйПуть);
КонецПроцедуры

//Я создаю файл "file02" в подкаталоге "folder0" рабочего каталога
Процедура ЯСоздаюФайлВПодкаталогеРабочегоКаталога(Знач ПутьФайла, Знач ПутьКаталога) Экспорт
	НовыйПуть = ОбъединитьПути(РабочийКаталог(), ПутьКаталога, ПутьФайла);
	СоздатьФайлПример(НовыйПуть);
КонецПроцедуры

//Я копирую файл "fixture.epf" из каталога "tests" проекта в рабочий каталог
Процедура ЯКопируюФайлИзКаталогаПроектаВРабочийКаталог(Знач ПутьФайла, Знач ПодКаталогПроекта) Экспорт
	ПолныйПутьФайла = ОбъединитьПути(БДД.КаталогПроверяемогоПроекта(), ПодКаталогПроекта, ПутьФайла);
	Файл = Новый Файл(ПолныйПутьФайла);
	КопироватьФайл(ПолныйПутьФайла, ОбъединитьПути(РабочийКаталог(), Файл.Имя));
КонецПроцедуры

//Я копирую файл "fixture.epf" из каталога "tests" проекта в подкаталог "folder0" рабочего каталога
Процедура ЯКопируюФайлИзКаталогаПроектаВПодкаталогРабочегоКаталога(Знач ПутьФайла, Знач ПодКаталогПроекта, Знач ПутьПодКаталога) Экспорт
	ПолныйПутьФайла = ОбъединитьПути(БДД.КаталогПроверяемогоПроекта(), ПодКаталогПроекта, ПутьФайла);
	Файл = Новый Файл(ПолныйПутьФайла);
	КопироватьФайл(ПолныйПутьФайла, ОбъединитьПути(РабочийКаталог(), ПутьПодКаталога, Файл.Имя));
КонецПроцедуры

//Я копирую каталог "fixtures" из каталога "tests" проекта в рабочий каталог
Процедура ЯКопируюКаталогИзКаталогаПроектаВРабочийКаталог(Знач ПутьНовогоКаталога, Знач ПодКаталогПроекта) Экспорт
	ПолныйПутьКаталога = ОбъединитьПути(БДД.КаталогПроверяемогоПроекта(), ПодКаталогПроекта, ПутьНовогоКаталога);
	ОбъектКаталога = Новый Файл(ПолныйПутьКаталога);
	// КопироватьФайл(ПолныйПутьФайла, ОбъединитьПути(РабочийКаталог(), ПутьПодКаталога, Файл.Имя));
	ПутьНовогоКаталога = ОбъединитьПути(РабочийКаталог(), ОбъектКаталога.Имя);
	ФС.ОбеспечитьКаталог(ПутьНовогоКаталога);
	ФС.КопироватьСодержимоеКаталога(ПолныйПутьКаталога, ПутьНовогоКаталога);
КонецПроцедуры

//Я копирую каталог "fixtures" из каталога "tests" проекта в подкаталог "folder0" рабочего каталога
Процедура ЯКопируюКаталогИзКаталогаПроектаВПодкаталогРабочегоКаталога(Знач ПутьНовогоКаталога, Знач ПодКаталогПроекта, Знач ПутьПодКаталога) Экспорт
	ПолныйПутьКаталога = ОбъединитьПути(БДД.КаталогПроверяемогоПроекта(), ПодКаталогПроекта, ПутьНовогоКаталога);
	ОбъектКаталога = Новый Файл(ПолныйПутьКаталога);
	
	ПутьНовогоКаталога = ОбъединитьПути(РабочийКаталог(), ПутьПодКаталога, ОбъектКаталога.Имя);
	ФС.ОбеспечитьКаталог(ПутьНовогоКаталога);
	ФС.КопироватьСодержимоеКаталога(ПолныйПутьКаталога, ПутьНовогоКаталога);
КонецПроцедуры

//В рабочем каталоге существует каталог "folder0"
Процедура ВРабочемКаталогеСуществуетКаталог(Знач ПутьКаталога) Экспорт
	ПолныйПуть = "";
	ФайлСуществует = ФайлИлиКаталогСуществует(ПутьКаталога, ПолныйПуть, Истина, РабочийКаталог());
	Ожидаем.Что(ФайлСуществует, СтрШаблон("Ожидаем, что каталог <%1> существует, а его нет!", ПолныйПуть)).ЭтоИстина();
КонецПроцедуры

//В подкаталоге "folder0" рабочего каталога существует каталог "folder02"
Процедура ВПодкаталогеРабочегоКаталогаСуществуетКаталог(Знач ПутьПодКаталога, Знач ПутьПроверяемогоКаталога) Экспорт
	ПолныйПуть = "";
	ФайлСуществует = ФайлИлиКаталогСуществует(ПутьПроверяемогоКаталога, ПолныйПуть, Истина, 
		ОбъединитьПути(РабочийКаталог(), ПутьПодКаталога));
	Ожидаем.Что(ФайлСуществует, СтрШаблон("Ожидаем, что каталог <%1> существует, а его нет!", ПолныйПуть)).ЭтоИстина();
КонецПроцедуры

//В рабочем каталоге существует файл "file0.txt"
Процедура ВРабочемКаталогеСуществуетФайл(Знач ПутьФайла) Экспорт
	ПолныйПуть = "";
	ФайлСуществует = ФайлИлиКаталогСуществует(ПутьФайла, ПолныйПуть, Ложь, РабочийКаталог());
	Ожидаем.Что(ФайлСуществует, СтрШаблон("Ожидаем, что файл <%1> существует, а его нет!", ПолныйПуть)).ЭтоИстина();
КонецПроцедуры

//В подкаталоге "folder0" рабочего каталога существует файл "file02"
Процедура ВПодкаталогеРабочегоКаталогаСуществуетФайл(Знач ПутьПодКаталога, Знач ПутьФайла) Экспорт
	ПолныйПуть = "";
	ФайлСуществует = ФайлИлиКаталогСуществует(ПутьФайла, ПолныйПуть, Ложь, 
		ОбъединитьПути(РабочийКаталог(), ПутьПодКаталога));
	Ожидаем.Что(ФайлСуществует, СтрШаблон("Ожидаем, что файл <%1> существует, а его нет!", ПолныйПуть)).ЭтоИстина();
КонецПроцедуры

//Каталог "folder0/folder01" существует
Процедура КаталогСуществует(Знач ПутьКаталога) Экспорт
	ПолныйПуть = "";
	ФайлСуществует = ФайлИлиКаталогСуществует(ПутьКаталога, ПолныйПуть, Истина);
	Ожидаем.Что(ФайлСуществует, СтрШаблон("Ожидаем, что каталог <%1> существует, а его нет!", ПолныйПуть)).ЭтоИстина();
КонецПроцедуры

//Каталог "folder0/folder01" не существует
Процедура КаталогНеСуществует(Знач ПутьКаталога) Экспорт
	ПолныйПуть = "";
	ФайлСуществует = ФайлИлиКаталогСуществует(ПутьКаталога, ПолныйПуть, Истина);
	Ожидаем.Что(ФайлСуществует, СтрШаблон("Ожидаем, что каталог <%1> нет, а он существует!", ПолныйПуть)).ЭтоЛожь();
КонецПроцедуры

//Файл "folder0/file01.txt" существует
Процедура ФайлСуществует(Знач ПутьФайла) Экспорт
	ПолныйПуть = "";
	ФайлСуществует = ФайлИлиКаталогСуществует(ПутьФайла, ПолныйПуть);
	Ожидаем.Что(ФайлСуществует, СтрШаблон("Ожидаем, что файл <%1> существует, а его нет!", ПолныйПуть)).ЭтоИстина();
КонецПроцедуры

//Файл "folder0/file01.txt" не существует
Процедура ФайлНеСуществует(Знач ПутьФайла) Экспорт
	ПолныйПуть = "";
	ФайлСуществует = ФайлИлиКаталогСуществует(ПутьФайла, ПолныйПуть);
	Ожидаем.Что(ФайлСуществует, СтрШаблон("Ожидаем, что файла <%1> нет, а он существует!", ПолныйПуть)).ЭтоЛожь();
КонецПроцедуры

Функция ФайлИлиКаталогСуществует(Знач ПутьФайла, ПолныйПуть, Знач ЭтоКаталог = Ложь, Знач ИсходныйКаталог = "")

	Лог.Отладка("ПутьФайла %1", ПутьФайла);
	Лог.Отладка("ПолныйПуть %1", ПолныйПуть);
	Лог.Отладка("ЭтоКаталог %1", ЭтоКаталог);
	Лог.Отладка("ИсходныйКаталог %1", ИсходныйКаталог);

	Если ИсходныйКаталог = "" Тогда
		ИсходныйКаталог = ТекущийКаталог();
	КонецЕсли;
	Лог.Отладка("Установили ИсходныйКаталог %1", ИсходныйКаталог);
	
	ПутьФайла = ЗаменитьШаблоныВПараметрахКоманды(ПутьФайла);

	РегулярноеВыражение = Новый РегулярноеВыражение("[\*,\?]");
	ПутьБезРегулярок = Не РегулярноеВыражение.Совпадает(ПутьФайла);
	
	Лог.Отладка("ПутьБезРегулярок %1", ПутьБезРегулярок);

	Рез = Ложь;
	//FIXME: убрать ПутьБезРегулярок после решения https://github.com/EvilBeaver/OneScript/issues/511
	Если ПутьБезРегулярок Тогда
		ПолныйПуть = (Новый Файл(ОбъединитьПути(ИсходныйКаталог, ПутьФайла))).ПолноеИмя;
		Лог.Отладка("Установили ПолныйПуть %1", ПолныйПуть);
		Объект = Новый Файл(ПолныйПуть);
		Рез = Объект.Существует();
		Лог.Отладка("Рез %1
		|	Объект.Существует()", Рез);
		Если Рез Тогда
			Рез = ЭтоКаталог И Объект.ЭтоКаталог() Или Не ЭтоКаталог И Не Объект.ЭтоКаталог();
			Лог.Отладка("новый Рез %1
			|	ЭтоКаталог И Объект.ЭтоКаталог() Или Не ЭтоКаталог И Не Объект.ЭтоКаталог()", Рез);
		КонецЕсли;
	Иначе		
		Попытка
			МассивФайлов = НайтиФайлы(ИсходныйКаталог, ПутьФайла);
			Рез = МассивФайлов.Количество() > 0;
			Лог.Отладка("МассивФайлов.Количество() %1", МассивФайлов.Количество());
			Лог.Отладка("Рез %1
			|	МассивФайлов.Количество() > 0", Рез);
		Исключение
			Лог.Отладка("ОписаниеОшибки %1", ОписаниеОшибки());
			Рез = Ложь;
		КонецПопытки;
		Если Рез Тогда
			Объект = МассивФайлов[0];
			Лог.Отладка("Объект %1", Объект.ПолноеИмя);
			Рез = ЭтоКаталог И Объект.ЭтоКаталог() Или Не ЭтоКаталог И Не Объект.ЭтоКаталог();
			Лог.Отладка("Рез %1
			|	ЭтоКаталог И Объект.ЭтоКаталог() Или Не ЭтоКаталог И Не Объект.ЭтоКаталог()", Рез);
		КонецЕсли;
	КонецЕсли;
	Возврат Рез;
КонецФункции

//Я установил рабочий каталог как текущий каталог
Процедура ЯУстановилРабочийКаталогКакТекущийКаталог() Экспорт
	СтекТекущихКаталогов = ПолучитьСтекТекущихКаталогов();
	СтекТекущихКаталогов.Вставить(0, ТекущийКаталог());

	УстановитьТекущийКаталог(РабочийКаталог());
КонецПроцедуры

//Я установил подкаталог "folder0" рабочего каталога как текущий каталог
Процедура ЯУстановилПодкаталогРабочегоКаталогаКакТекущийКаталог(Знач ПутьКаталога) Экспорт
	ПолныйПутьКаталога = ОбъединитьПути(РабочийКаталог(), ПутьКаталога);
	
	СтекТекущихКаталогов = ПолучитьСтекТекущихКаталогов();
	СтекТекущихКаталогов.Вставить(0, ТекущийКаталог());

	УстановитьТекущийКаталог(ПолныйПутьКаталога);
КонецПроцедуры

//Я восстановил предыдущий каталог
Процедура ЯВосстановилПредыдущийКаталог() Экспорт
	СтекТекущихКаталогов = ПолучитьСтекТекущихКаталогов();
	Если Не ЗначениеЗаполнено(СтекТекущихКаталогов) Тогда
		ВызватьИсключение "Невозможно восстановить каталог, т.к. стек текущих каталогов пуст";
	КонецЕсли;
	
	УстановитьТекущийКаталог(СтекТекущихКаталогов[0]);
	СтекТекущихКаталогов.Удалить(0);
КонецПроцедуры

//Я сохраняю каталог проекта в контекст
Процедура ЯСохраняюКаталогПроектаВКонтекст() Экспорт
	КаталогТекущегоПроекта = БДД.КаталогПроверяемогоПроекта();
	БДД.СохранитьВКонтекст("КаталогПроекта", КаталогТекущегоПроекта);
КонецПроцедуры

//Я показываю каталог проекта
Процедура ЯПоказываюКаталогПроекта() Экспорт
	Сообщить(БДД.ПолучитьИзКонтекста("КаталогПроекта"));
КонецПроцедуры

//Я показываю рабочий каталог
Процедура ЯПоказываюРабочийКаталог() Экспорт
	Сообщить(РабочийКаталог());
КонецПроцедуры

//Я показываю текущий каталог
Процедура ЯПоказываюТекущийКаталог() Экспорт
	Сообщить(ТекущийКаталог());
КонецПроцедуры

//Файл "folder0/file01.txt" в рабочем каталоге содержит "Текст файла"
Процедура ФайлВРабочемКаталогеСодержит(Знач ПутьФайла, Знач ЧтоИщем) Экспорт
	ПутьФайла = ЗаменитьШаблоныВПараметрахКоманды(ПутьФайла);

	Файл = Новый Файл(ОбъединитьПути(РабочийКаталог(), ПутьФайла)); 
	ПроверитьСодержимоеФайла(Файл, ЧтоИщем);
КонецПроцедуры

//Файл "folder0/file01.txt" в рабочем каталоге не содержит "Не существующий текст"
Процедура ФайлВРабочемКаталогеНеСодержит(Знач ПутьФайла, Знач ЧтоИщем) Экспорт
	ПутьФайла = ЗаменитьШаблоныВПараметрахКоманды(ПутьФайла);

	Файл = Новый Файл(ОбъединитьПути(РабочийКаталог(), ПутьФайла)); 
	ПроверитьОтсутствиеВФайле(Файл, ЧтоИщем);
КонецПроцедуры

//Файл "folder0/file01.txt" содержит "Текст файла"
Процедура ФайлСодержит(Знач ПутьФайла, Знач ЧтоИщем) Экспорт
	ПутьФайла = ЗаменитьШаблоныВПараметрахКоманды(ПутьФайла);

	Файл = Новый Файл(ОбъединитьПути(ТекущийКаталог(), ПутьФайла)); 
	ПроверитьСодержимоеФайла(Файл, ЧтоИщем);
КонецПроцедуры

//Файл "folder0/file01.txt" не содержит "Не существующий текст"
Процедура ФайлНеСодержит(Знач ПутьФайла, Знач ЧтоИщем) Экспорт
	ПутьФайла = ЗаменитьШаблоныВПараметрахКоманды(ПутьФайла);

	Файл = Новый Файл(ОбъединитьПути(ТекущийКаталог(), ПутьФайла)); 
	ПроверитьОтсутствиеВФайле(Файл, ЧтоИщем);
КонецПроцедуры

//я удаляю файл "<КаталогПроекта>/apache/apache_VDC.conf"
Процедура ЯУдаляюФайл(Знач ПутьФайла) Экспорт
	ПутьФайла = ЗаменитьШаблоныВПараметрахКоманды(ПутьФайла);
	ПутьФайла = ОбъединитьПути(ТекущийКаталог(), ПутьФайла);
	Файл = Новый Файл(ПутьФайла);
	Если Файл.Существует() Тогда
		УдалитьФайлы(ПутьФайла);
	КонецЕсли;
КонецПроцедуры

//{ Служебные методы
Функция РабочийКаталог()
	Возврат БДД.ПолучитьИзКонтекста("РабочийКаталог");
КонецФункции

Функция ПолучитьСтекТекущихКаталогов()
	СтекТекущихКаталогов = БДД.ПолучитьИзКонтекста("СтекТекущихКаталогов");
	Если СтекТекущихКаталогов = Неопределено Тогда
		СтекТекущихКаталогов = Новый Массив;
		БДД.СохранитьВКонтекст("СтекТекущихКаталогов", СтекТекущихКаталогов);
	КонецЕсли;
	Возврат СтекТекущихКаталогов;
КонецФункции // Получить()

Процедура СоздатьФайлПример(Знач ПутьФайла) Экспорт
	ЗаписьТекста = Новый ЗаписьТекста(ПутьФайла);
	ЗаписьТекста.Записать("Текст файла");
	ЗаписьТекста.Закрыть();
КонецПроцедуры

Функция ПрочитатьТекстФайла(Знач Файл, Кодировка = "UTF-8")
	ЧтениеТекста = Новый ЧтениеТекста;
	ЧтениеТекста.Открыть(Файл.ПолноеИмя, Кодировка);

	Строка = ЧтениеТекста.Прочитать();
	ЧтениеТекста.Закрыть();
	Возврат Строка;
КонецФункции // ПрочитатьТекстФайла()

Процедура ПроверитьСодержимоеФайла(Знач Файл, Знач ЧтоИщем)
	ТекстФайла = ПрочитатьТекстФайла(Файл);
	ТекстФайла = ЗаменитьШаблоныВПараметрахКоманды(ТекстФайла);
	ЧтоИщем = ЗаменитьШаблоныВПараметрахКоманды(ЧтоИщем);

	ОписаниеОшибки = СтрШаблон("Ожидали, что файл <%1> содержит `<%2>`, а это не так!", Файл.ПолноеИмя, ЧтоИщем);
	Ожидаем.Что(ТекстФайла, ОписаниеОшибки).Содержит(ЧтоИщем);
КонецПроцедуры

Процедура ПроверитьОтсутствиеВФайле(Знач Файл, Знач ЧтоИщем)
	ТекстФайла = ПрочитатьТекстФайла(Файл);
	ТекстФайла = ЗаменитьШаблоныВПараметрахКоманды(ТекстФайла);
	ЧтоИщем = ЗаменитьШаблоныВПараметрахКоманды(ЧтоИщем);

	ОписаниеОшибки = СтрШаблон("Ожидали, что файл <%1> не содержит `<%2>`, а это не так!", Файл.ПолноеИмя, ЧтоИщем);
	Ожидаем.Что(ТекстФайла, ОписаниеОшибки).Не_().Содержит(ЧтоИщем);
КонецПроцедуры

// TODO исключить дублирование ЗаменитьШаблоныВПараметрахКоманды из 1bdd 
Функция ЗаменитьШаблоныВПараметрахКоманды(Знач ПараметрыКоманды)
	КаталогПроекта = БДД.КаталогПроверяемогоПроекта();
	РабочийКаталог = РабочийКаталог();

	Рез = СтрЗаменить(ПараметрыКоманды, "<КаталогПроекта>", КаталогПроекта);
	Рез = СтрЗаменить(Рез, "<РабочийКаталог>", РабочийКаталог);

	Рез = СтрЗаменить(Рез, "<КаталогПроектаДвойныеСлеши>", ЗаменитьСлешиНаДвойныеСлеши(КаталогПроекта));
	Рез = СтрЗаменить(Рез, "<РабочийКаталогДвойныеСлеши>", ЗаменитьСлешиНаДвойныеСлеши(РабочийКаталог));
	Возврат Рез;
КонецФункции

Функция ЗаменитьСлешиНаДвойныеСлеши(Знач Строка)
	Рез = СтрЗаменить(Строка, "\", "\\");
	Возврат Рез;	
КонецФункции
//}

Лог = Логирование.ПолучитьЛог("bdd");
