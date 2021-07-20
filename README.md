# putinSquads
pew!pew!
Что нового я узнал с этого проекта:
1) Создание элементов UI кодом:
- Import UIKIT()
- Во view did load, вызвать функцию создания UI, которую я сам напишу. 
- Для создания любого элемента нужны минимум эти вещи: 
a) let squareView = UIView() - я создал объект
b) view.addSubview(squareView) - я добавил объект на экран.
c) let constraints = [NSLayoutConstraint] - мне нужно обозначить, где будут находиться мои объекты
d) NSLayoutContstraints.activate(constraints) - contstraints нужно активировать, иначе ничего не произойдет - я просто создал array.
e) squareView.translatesAutoresizingMaskIntoConstraints = false - я сам прописал constraints, мне не нужен этот функционал. (О нём все равно стоит почитать).

2) Новый функционал лучше добавлять через MARKS + Extensions - от этого код чище, проще проверять различные изменения. 

3) Чтобы кнопка что-то делала, не нужны IBAction outlets (я делаю не через сториборд), но нужны свои функции.
a) button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside) (Не понимаю, почему selector пишется через #, нужно в целом разобрать значение addTarget)
b)  @objc func buttonAction(sender: UIButton!) - это функция, которую я прописываю в addTarget. 

4)UITableView() 
A) TableView нужен data source
B) В TableView нужно регистрировать клетку. Либо свою собственную, либо стандартную.tableView.register(Cell, "CellID")
C) DataSource должен conform to data source protocol. Минимум две функции: 
- number of rows - Сколько рядов в таблице expects INT
- cell for row - какие клетки он будет выдавать expects UITableViewCell
a) Внутри cellForRow нужно создать константу: let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as? MyCustomCell
dequeReusableCell вызывает Init класса моей кастомной клетки. - он просто создаст мне пустую клетку
b) cell?.configure(title: нужный тайтл, picture: нужная картинка): configure - это публичная функция, которую я сам создал, чтобы внутри клетки информация была разная.
configure наполнит клетку, которую я создал через deque контентом. 
c) Return cell! - вернет мне клетку, которая создана через deque и configured через мною прописанную функцию. 
у UITableView есть другие функции, которые можно вызвать через func tableView, например, numberOfSections и headerForSection. 
___________________________________
Лучший способ достать из array нужную информацию в tableView и не запутаться - доставать инфу сверху вниз:
1) Определить количество секций в таблице, 
2) Определить для каждой секции заголовок,
3) Определить количество рядов в каждой секции,
4) Определить информацию для каждой клетки в ряде.
_____________________________________

5) Создание кастомной клетки для UITableView:
- Создать новый класс. (там изначально инициализируем, какого типа объекты нам понадобятся: private let label = UILabel() )
-В классе override init - вызвать свою функцию сетапа отдельной клетки. (чтоб dequeReusableCell в tableView это вызвало потом)
- private func setupViews - делаешь всё то же самое, что делал бы в ViewController с обычным квадратом. (прописываешь все необходимые элементы).
НО вместо veiw.addSubview пишешь contentView.addSubview. 
- Создаешь публичную функцию configure - функция будет вызываться через ViewController, эта функция должна определять, какой именно объект будет в клетке. 

6) Когда в TableViewCell нужнен всего лишь один объект, можно просто закинуть значения этого объекта в один массив (например, Strings для сэтапа одного лейбла)
Но когда нужно более одного объекта или если есть деление таблицы на секции, будет проще и понятнее создать отдельные Structs. Это позволит избежать массива в массиве в массиве в массиве

__________________
ИЗ ТЕЛЕГИ: 
1) ты задаешь констрейнт для label отступом от левой границы экрана
ты можешь сначала сделать констрейнты картинки, а для сделать image.leading = image.trailing + 10 (Посмотреть/поменять). 
2) чтобы инициализировать ViewController (как и любой другой класс) должны быть проинициализированы все его переменные. 
(Поэтому я ставлю "!" в самом начале кода - я по ходу кода скажу, чему оно будет равно).
3) Optional переменные автоматически инициализируются как nil. (Полезно понимать, чтобы приложение не крашилось).
4) // У Table View Должен быть Дата Сорс - в этом случае она:
        putinTableView.dataSource = self //
Тут коммент не совсем корректный. Дата сурсом в данном случае будет сам ViewController tableView делегирует ответственность за наполнение данными вью контроллеру
(получается, self обращается к классу, в котором этот кусок кода находится. Потому мне и нужно, чтобы ViewController conform to dataSource protocol)
5) TableViewCell является классом, у него есть свой Init. Когда я Override init, я сначала делаю super.init(инициализирую всё то, что за меня прописали), а потом вызываю свои функции. 
6) required init? в классе клетки нужен только при создании ее через interface builder. Я в своем классе этот код иметь обязан, но менять там ничего не нужно. 
7) "Вот метод setupLocationDelegate лучше перенести в extension с приватными методами
а в этом extension оставить только методы протокола CLLocationManagerDelegate" 
(не перенес, не понял, зачем я это делаю. Всё равно функционал Location полностью не понимаю. Я должен заново посмотреть, что именно я написал в коде и как это сделать красивее.)
8) ...locationManager?.requestAlwaysAuthorization()
Тут у тебя крэшится скорее всего из-за того, что для использования таких штук нужно в Info.plist добавить параметр со строкой, 
объясняющей пользователю зачем ты будешь использовать это разрешение. (не забывать прописывать в info параметр requestAuthorisation. whenInUse отличается от Always)
___________________________________________________________
Ресурсы: 
1) Обязательно читать swiftbook.ru
2) https://www.swiftbysundell.com/basics/ - тут даже есть basics тэг для меня. Полезно. 
3) https://swiftbook.ru/content/languageguide/automatic-reference-counting/ - это про weak var. (так же упомянули про optional initializes as nil)
4) https://dmytro-anokhin.medium.com/delegate-in-swift-47b3d6fcecc3 - это про delegates.
5) https://swiftbook.ru/post/tutorials/swift-chast-3-korteji-protokoly-delegaty-i-tablichnyy-format/ - кортежи и делегаты на реальном примере. 
____________________________________________________________
Какие вопросы появились: 
1) Какой я паттерн использую в этом коде 
(Тут вообще есть паттерн? Если MVC - то Model у меня мои Structs и Class клетки, а вью и контроллер у меня во ViewController) - хочу чуть лучше это понимать. 
Чуть более осознанно создавать отдельные файлы в проектах (сейчас я понимаю, зачем мне structs и cellClass)
2) Structs are passed by value, Classes are passed by reference. Only classes can enherit. Delegates are only possible in class. 
Это хорошо, но объяснить, что значит reference и вэлью я не смогу. В целом, классы я бы использовал, когда нужно создать голубя и петуха из птицы. 
А стракты бы использовал для более удобного хранения статичной информации. Глубокое понимание разницы у меня отсутствует. 
3) Self - указатель. Что такое указатели? Зачем они нужны? В связи с непониманием delegates не понимаю self. 
4) button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside) - 
self - указывает на ViewController в моем случае, 
#selector (почему через "#" оно пишется?) - почему называется #selector а не action, например? Если я тут должен написать функцию кнопки. 
for: .touchUpInside - control state - оно понятно, есть разные states кнопки. (значит ли это, что через addTarget можно прописать buttonTitle for: .normal ?) 
______________________________________________________
Что сделать, чтобы проще было писать код: 
1) Узнать разницу Structs и Classes
2) Полностью понимать, когда и зачем нужны delegates
3) Узнать, какие еще есть функции в tableView (наверняка, кроме секций есть еще что-то крутое)
4) Написать еще одно приложение с TableView, чтобы больше проблем с этим не возникало. 


