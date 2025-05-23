//----------------------------------------------------------
//This Source Code Form is subject to the terms of the
//Mozilla Public License, v.2.0. If a copy of the MPL
//was not distributed with this file, You can obtain one
//at http://mozilla.org/MPL/2.0/.
//----------------------------------------------------------

//////////////////////////////////////////////////////////////////
//
// Объект-помощник для чтения файла фич
//
//////////////////////////////////////////////////////////////////

Перем ЧтениеТекста;
Перем КоллекцияСтрок;
Перем ПозицияВКоллекции;

////////////////////////////////////////////////////////////////////
//{ Программный интерфейс

// Пост-конструктор класса из файла
//
Процедура Инициализировать(Знач ПутьФайла, Знач Кодировка = "UTF-8") Экспорт
    КоллекцияСтрок = Новый Массив;
    ПозицияВКоллекции = -1;
    
    ЧтениеТекста = Новый ЧтениеТекста(ПутьФайла, Кодировка);
    ПрочитатьТекстВКоллекцию();
КонецПроцедуры

// Пост-конструктор класса из строки
//
// Параметры:
//   Строка - тип Строка
//
Процедура ИнициализироватьИзСтроки(Знач Строка) Экспорт
    КоллекцияСтрок = Новый Массив;
    ПозицияВКоллекции = -1;
    
    ЧтениеТекста = Неопределено;
    ПрочитатьСтрокуВКоллекцию(Строка);
КонецПроцедуры

// Закрывает объект
//
Процедура Закрыть() Экспорт
    Если ЧтениеТекста <> Неопределено Тогда
        ЧтениеТекста.Закрыть();
    КонецЕсли;
КонецПроцедуры

// Прочесть очередную строку
//
//  Возвращаемое значение:
//   Строка или Неопределено - очередная строка или признак завершения чтения
//
Функция ПрочитатьСтроку() Экспорт
    ПозицияВКоллекции  = ПозицияВКоллекции  + 1;
    Если ПозицияВКоллекции >= КоллекцияСтрок.Количество() Тогда
        Возврат Неопределено;
    КонецЕсли;

    ОчереднаяСтрока = КоллекцияСтрок[ПозицияВКоллекции];
    Возврат ОчереднаяСтрока;
КонецФункции // ОчереднаяСтрока()

// Вернуться на одну строку обратно для возможности повторного ее прочтения
//
Процедура ВернутьсяНаСтрокуНазад() Экспорт
    ПозицияВКоллекции  = ПозицияВКоллекции  - 1;
КонецПроцедуры

//}

Процедура ПрочитатьТекстВКоллекцию()
    Пока Истина Цикл
        ОчереднаяСтрока = ЧтениеТекста.ПрочитатьСтроку();
        Если ОчереднаяСтрока = Неопределено Тогда
            Прервать;
        КонецЕсли;
        КоллекцияСтрок.Добавить(ОчереднаяСтрока);
    КонецЦикла;

КонецПроцедуры

Процедура ПрочитатьСтрокуВКоллекцию(Знач Строка)
    Для Счетчик = 1 По СтрЧислоСтрок(Строка) Цикл
        ОчереднаяСтрока = СтрПолучитьСтроку(Строка, Счетчик);
        КоллекцияСтрок.Добавить(ОчереднаяСтрока);
    КонецЦикла;

КонецПроцедуры