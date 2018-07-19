#Использовать configor

Перем Лог; // Объект, для логирования

// Перем УдалятьВременныеФайлы; // Булево, признак удаления временных файлов

Перем АвторизацияНаКластереСерверов; // Структура ключи <АдминистраторКластера>, <ПарольАдминистратораКластера>

// ///////////////////////////////////////////////////////////////////////////////////////////////
// // ПРОГРАММНЫЙ ИНТЕРФЕЙС

Перем ТекущаяВерсияПлатформы Экспорт; // Строка, используемая версия 1С.Предприятие

Перем ИнформационнаяБаза;
Перем КоличествоПопытокОтключения;
Перем ПутьКФайлуНастроек;

Перем Параметры;

#Область Публичное_API
// Устанавливает параметры авторизации на кластере серверов 1С
//
// Параметры:
//   Пользователь - Строка - пользователь кластера серверов 1С
//   Пароль - Строка - пароль пользователя кластера серверов 1С
//
// Возвращаемое значение:
//   Объект.МенеджерКоманд - ссылка на текущий объект класса <МенеджерКоманд>
//
Функция АвторизацияНаКластереСерверов(Знач Пользователь, Знач Пароль) Экспорт

	Лог.Отладка("Установлена авторизация на кластере серверов 1С: пользователь <%1>, пароль <%2>", Пользователь, Пароль);
	АвторизацияНаКластереСерверов.Вставить("АдминистраторКластера" , Пользователь);
	АвторизацияНаКластереСерверов.Вставить("ПарольАдминистратораКластера", Пароль);

	Возврат ЭтотОбъект;

КонецФункции

// Устанавливает уровень вывода логов
//
// Параметры:
//   НовыйУровеньЛога - Строка - уровень вывода лога
//
// Возвращаемое значение:
//   Объект.МенеджерКоманд - ссылка на текущий объект класса <МенеджерКоманд>
//
Функция УровеньЛога(Знач НовыйУровеньЛога) Экспорт

	Лог.УстановитьУровень(НовыйУровеньЛога);
	Возврат ЭтотОбъект;

КонецФункции

// Устанавливает версию платформы 1С
//
// Параметры:
//   НоваяВерсияПлатформы - Строка - версия платформы 1С используемой для работы
//
// Возвращаемое значение:
//   Объект.МенеджерКоманд - ссылка на текущий объект класса <МенеджерКоманд>
//
Функция ВерсияПлатформы(Знач НоваяВерсияПлатформы) Экспорт

	ТекущаяВерсияПлатформы = НоваяВерсияПлатформы;
	Возврат ЭтотОбъект;

КонецФункции

// Устанавливает путь к файлу настроек
//
// Параметры:
//   НовыйПутьКФайлуНастроек - Строка - путь к файлу настроек
//
// Возвращаемое значение:
//   Объект.МенеджерКоманд - ссылка на текущий объект класса <МенеджерКоманд>
//
Функция УстановитьНастройки(НовыйПутьКФайлуНастроек) Экспорт
	ПутьКФайлуНастроек = НовыйПутьКФайлуНастроек;
	Возврат ЭтотОбъект;
КонецФункции

// Устанавливает количество попыток отключения пользователей
//
// Параметры:
//   КоличествоПопыток - Число - количество попыток отключения пользователей
//
// Возвращаемое значение:
//   Объект.МенеджерКоманд - ссылка на текущий объект класса <МенеджерКоманд>
//
Функция КоличествоПопытокОтключения(Знач КоличествоПопыток) Экспорт
	КоличествоПопытокОтключения = КоличествоПопыток;
	Возврат ЭтотОбъект;
КонецФункции

// Устанавливает информационную базу
//
// Параметры:
//   ИнформационнаяБазаПодключения - Строка - информационная база
//
// Возвращаемое значение:
//   Объект.МенеджерКоманд - ссылка на текущий объект класса <МенеджерКоманд>
//
Функция ИнформационнаяБаза(Знач ИнформационнаяБазаПодключения) Экспорт
	ИнформационнаяБаза = ИнформационнаяБазаПодключения;
	Возврат ЭтотОбъект;
КонецФункции

Процедура ПрочитатьФайлНастроек() Экспорт

	МенеджерПараметров = Новый МенеджерПараметров();
	МенеджерПараметров.УстановитьФайлПараметров(ПутьКФайлуНастроек);
	МенеджерПараметров.ИспользоватьПровайдерJSON();
	МенеджерПараметров.ИспользоватьПровайдерYAML();
	МенеджерПараметров.КонструкторПараметров(ЭтотОбъект);
	
	Лог.Отладка("Чтение файла настроек начато");
	МенеджерПараметров.Прочитать();
	Лог.Отладка("Чтение файла настроек завершено");

КонецПроцедуры

#КонецОбласти

#Область Интерфейс_конструктора_параметров

Функция Параметры() Экспорт
	Возврат Параметры;
КонецФункции

Процедура УстановитьПараметры(Знач ВходящиеПараметры) Экспорт
	Параметры = ВходящиеПараметры;
КонецПроцедуры

Процедура ОписаниеПараметров(Знач Конструктор) Экспорт

	НастройкиПоУмолчанию = Конструктор.НовыеПараметры("Параметры");

	НастройкиПоУмолчанию = Конструктор.НовыеПараметры("Параметры")
						.ПолеСтрока("ИнформационнаяБаза ibconnection --ibconnection", ИнформационнаяБаза)
						.ПолеСтрока("АдминистраторКластера db-user --db-user", АвторизацияНаКластереСерверов.АдминистраторКластера)
						.ПолеСтрока("ПарольАдминистратораКластера db-pwd --db-pwd", АвторизацияНаКластереСерверов.ПарольАдминистратораКластера)
						.ПолеЧисло("КоличествоПопыток try --try", КоличествоПопытокОтключения)
						;
	
	Конструктор.ПолеОбъект("НастройкиПоУмолчанию default", НастройкиПоУмолчанию);

КонецПроцедуры

#КонецОбласти

Процедура ПриСозданииОбъекта()

	АвторизацияНаКластереСерверов = Новый Структура;
	Лог = ПараметрыПриложения.Лог();

КонецПроцедуры