# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create!(name: 'Emanuel', city: cities.first)
# Product.delete_all

Product.create!(title: 'Маркер перманентный, красный, круглый пиш. узел 1',
			    price: 15.14,
			    category: 'Прочее',
			    subcategory: 'Прочие товары',
			    category_id: 1)
Product.create!( title: '1310 Каталка Собака (25 см)',
			    price: 288.9,
			    category: 'Каталки, песочные наборы и мыльные пузыри',
			    subcategory: 'Каталки')
Product.create!( title: 'Санки "Вятские-03" (Киров)5шт/уп',
			    price: 100,
			    category: 'Зима',
			    category_id: 2,
			    subcategory: 'Санки')
Product.create!( title: '266 пома Погремушка "Телефон" 1019',
			    price: 70.01,
			    category: 'Для малышей',
			    subcategory: 'Погремушки')
Product.create!( title: 'IP6214R ЭЛЕКТРОННЫЙ ПЛАКАТ "УМКА" "ВИННИ ПУХ И ЕГО',
			    price: 447.15,
			    category: 'Настольные игры и компьютеры',
			    subcategory: 'Электронные плакаты')
Product.create!( title: '98461 Hasbro / TRA Игровой набор "Собери Большого',
			    price: 1144.8,
			    category: 'Товары для детского творчества',
			    subcategory: 'Наборы и товары для творчества')
Product.create!( title: '13042 (12) Курносики Соска-пустышка силикон (2шт)',
			    price: 92.67,
			    category: 'Для малышей',
			    category_id: 3,
			    subcategory: 'Пластизоль')
Product.create!( title: '02834 Дракон',
			    price: 608.85,
			    category: 'Игры и игрушки для мальчиков',
			    category_id: 6,
			    subcategory: 'Наборы, наборы солдатиков и др.')
Product.create!( title: '6866-17 набор рыцаря',
			    price: 72.9,
			    category: 'Игры и игрушки для мальчиков',
			    category_id: 6,
			    subcategory: 'Оружие, доспехи')
Product.create!( title: '700006271 Famosa / Мягкий пупс Ненуко 35 см + апте',
			    price: 1574.1,
			    category: 'Куклы',
			    category_id: 7,
			    subcategory: 'Куклы мягконабивные')
Product.create!( title: '782947 Гримассимус',
			    price: 812.7,
			    category: 'Товары для праздников, развлечений и ролевых игр',
			    category_id: 8,
			    subcategory: 'Шарики и прочее')
Product.create!( title: '29830 (29717, 29719, 29836) Mega Bloks / Магнитный',
			    price: 2214,
			    category: 'Конструкторы',
			    category_id: 10,
			    subcategory: 'Металлические и магнитные')
Product.create!( title: '8839 Mega Bloks / Набор кубиков Макси "Зоопарк"',
			    price: 0,
			    category: 'Конструкторы',
			    category_id: 10,
			    subcategory: 'Пластмассовые')
Product.create!( title: 'С-002-25 Медведь мальчик CHOCO стоячий 25 см',
			    price: 447.24,
			    category: 'Мягкая игрушка',
			    category_id: 11,
			    subcategory: 'Мягкая игрушка')
Product.create!( title: '2319 Игрушка д/ванны Лягушонок 2319',
			    price: 59.95,
			    category: 'Для малышей',
			    subcategory: 'Игры и игрушки для ванной комнаты')
Product.create!( title: 'PTG-CB100(PI)/12482 куколка из лепестков',
			    price: 154.11,
			    category: 'Куклы',
			    category_id: 7,
			    subcategory: 'Куклы ')
Product.create!( title: '03338 Игрушка-каталка "Жучок" (от 12 мес) (1021610',
			    price: 0,
			    category: 'Каталки, песочные наборы и мыльные пузыри',
			    category_id: 4,
			    subcategory: 'Каталки')
Product.create!( title: '7940 C Большой набор массы для моделирования (3 шт',
			    price: 275.4,
			    category: 'Товары для детского творчества',
			    category_id: 8,
			    subcategory: 'Лепка')
Product.create!( title: 'A24-2088_ Пазл Astrel 24-maxi Куклы (Россия) (РОСС',
			    price: 42.64,
			    category: 'Пазлы',
			    category_id: 13,
			    subcategory: 'Пазлы')
Product.create!( title: 'E03-918 РОГАТКА ДЕРЕВЯНН. В АССОРТ. В ПАК. 22*13СМ',
			    price: 36.96,
			    category: 'Спорт и летние игры',
			    category_id: 12,
			    subcategory: 'Спортивные игры и аксессуары')
Product.create!( title: '28020 Лошадки Страц 15 см. 6 в асс-те.',
			    price: 912.47,
			    category: 'Игры и игрушки для девочек',
			    category_id: 6,
			    subcategory: 'Игры и игрушки для девочек')
Product.create!( title: '93572 Hasbro / MARVEL ЧЕЛОВЕК-ПАУК НА ТРАНСПОРТНОМ',
			    price: 728.16,
			    category: 'Трансформеры и коллекционные машинки',
			    subcategory: 'Игрушки трансформеры')
Product.create!( title: '02743 Румми/компактная версия',
			    price: 202.2,
			    category: 'Настольные игры и компьютеры',
			    subcategory: 'Настольно-печатные игры')
Product.create!( title: 'TC7002/T Хрюша, 40 см',
			    price: 502.91,
			    category: 'Мягкая игрушка',
			    category_id: 11,
			    subcategory: 'Мягкая игрушка')
Product.create!( title: '90080(90081,90082,90083,90194,90197,90198) Play Al',
			    price: 256.5,
			    category: 'Для малышей',
			    category_id: 3,
			    subcategory: 'Предметно-развивающие игры и наборы')
Category.create!(
	name: 'Прочее',
	url_name: 'Other'
	)
Category.create!(
	name: 'Зима',
	url_name: 'Zima'
	)
Category.create!(
	name: 'Для малышей',
	url_name: 'Dlya_malishey'
	)
Category.create!(
	name: 'Каталки, песочные наборы и мыльные пузыри',
	url_name: 'Katalki_i_drugoe'
	)
Category.create!(
	name: 'Настольные игры и компьютеры',
	url_name: 'Nastolnie_igri_i_dr'
	)
Category.create!(
	name: 'Товары для детского творчества',
	url_name: 'Tovari_dlya_tvorchestva'
	)
Category.create!(
	name: 'Игры и игрушки для малышей',
	url_name: 'Igri_i_igrushki'
	)
Category.create!(
	name: 'Куклы',
	url_name: 'Kykli'
	)
Category.create!(
	name: 'Товары для праздников',
	url_name: 'Tovari_dlya_prazdnikov'
	)
Category.create!(
	name: 'Конструкторы',
	url_name: 'Konstruktori'
	)
Category.create!(
	name: 'Мягкая игрушка',
	url_name: 'Mygkaya_igrushka'
	)
Category.create!(
	name: 'Спорт',
	url_name: 'Sport'
	)
Category.create!(
	name: 'Пазлы',
	url_name: 'Pazli'
	)

Subcategory.create!(
	category_id: 1,
	name: 'Прочие товары',
	url_name: 'Prochie_tovari'
	)
Subcategory.create!(
	category_id: 2,
	name: 'Санки',
	url_name: 'Sanki'
	)
Subcategory.create!(
	category_id: 3,
	name: 'Погремушки',
	url_name: 'Pogremushki'
	)
Subcategory.create!(
	category_id: 4,
	name: 'Предметно-развивающие игры',
	url_name: 'predmetno_razvivayshie'
	)
Subcategory.create!(
	category_id: 5,
	name: 'Игры и игрушки для ванной комнаты',
	url_name: 'Igri_i_igrushki_dlya_vannoy_komnaty'
	)
Subcategory.create!(
	category_id: 6,
	name: 'Пластизоль',
	url_name: 'Plastizol'
	)
Subcategory.create!(
	category_id: 7,
	name: 'Каталки',
	url_name: 'Katalki'
	)
