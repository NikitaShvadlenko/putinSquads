//
//  ViewController.swift
//  putinSquads
//
//  Created by Nikita Shvad on 13.07.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    //Почему тут нужен force unwrapping?(я заметил, что без него не работает) Почему нельзя сразу ставить "=", а нужно именно двоеточие? Как правильно это называть?
    //Декларирую SquareView вверху, чтобы мог добавить Label в него
    ///hihih
    private var squareView: UIView!
    
    private var putinSquadUnit = [
        SectionItem.init(title: "Власть", rows: [Rowitem.init(title: "Омон", imageName: "hammer"), Rowitem.init(title: "Автозак", imageName: "car")]),
        SectionItem.init(title: "Деньги", rows: [Rowitem.init(title: "Налоговая", imageName: "pencil"), Rowitem.init(title: "Эффективный Менеджер", imageName: "clock")]),
        SectionItem.init(title: "Пропаганда", rows: [Rowitem.init(title: "Артисты Эстрады", imageName: "star")])
    ]
    private var headerName = ""
    private var putinTableView: UITableView!
    private var button: UIButton!
    private var locationManager: CLLocationManager?
    private var latitude: Double = 0.0
    private var longitude: Double = 0.0
    private var randomNumber = Int.random(in: 150000...158001)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableView()
        setupButton()
    }
    // Делаю функцию для квадрата, чтобы вызвать ViewDidLoad
    private func setupViews (){
        //Базовый Сетап квадрата - Это UIVIEW с красным бэкграундом.
        squareView = UIView()
        squareView.backgroundColor = .red
        // Убираю авторесайзингМаск, и добавляю сабвью - иначе не появится ничего
        squareView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(squareView)
        
        let squareViewConstraints = [
            NSLayoutConstraint(item: squareView!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: squareView!, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: squareView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: squareView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIApplication.shared.statusBarFrame.height + 50)
        ]
        //Активирую констраитсы, иначе я просто сделал массив, который не используется.
        NSLayoutConstraint.activate(squareViewConstraints)
    
        let putinSquadLabel = UILabel()
        putinSquadLabel.text = "ОТРЯДЫ ПУТИНА"
        putinSquadLabel.textColor = .white
        putinSquadLabel.font = UIFont.boldSystemFont(ofSize: 50)
        putinSquadLabel.minimumScaleFactor = 0.1
        putinSquadLabel.adjustsFontSizeToFitWidth = true
        putinSquadLabel.textAlignment = .center
      
        
        putinSquadLabel.translatesAutoresizingMaskIntoConstraints = false
        
        squareView.addSubview(putinSquadLabel)
        
        let putinLabelConstraints = [
            NSLayoutConstraint(item: putinSquadLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: putinSquadLabel, attribute: .leading, relatedBy: .equal, toItem: squareView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: putinSquadLabel, attribute: .trailing, relatedBy: .equal, toItem: squareView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: putinSquadLabel, attribute: .bottom, relatedBy: .equal, toItem: squareView, attribute: .bottom, multiplier: 1, constant: 0)
        ]
        NSLayoutConstraint.activate(putinLabelConstraints)
}
}

//MARK: - Setup Table View
extension ViewController {
    private func setupTableView () {
        
        putinTableView = UITableView()
        putinTableView.backgroundColor = .blue
        // У Table View Должен быть Дата Сорс - в этом случае она
        putinTableView.dataSource = self
        
        //Регистрирую клетку, которую я создал как отдельный класс. Чтобы использовать, нужно всегда регистрировать. Это может быть Nib или стандартный UITableViewCell или мой кастомный - надо дать знать, чем я собираюсь наполнять этот TableView.
        
        putinTableView.register(PutinSquadCell.self, forCellReuseIdentifier: "PutinSquadCellIdentifier")
        
        //Стандартные вещи, которые я пишу для корректного отображения TableView - убираю лишний Autoresizing Mask, добавляю сабвью во вью, чтоб table view появилась
        
        putinTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(putinTableView)
        
        //Сетаплю Констраинтсы для своего ТаблеВью
        
        let putinTableViewConstraints = [
            NSLayoutConstraint(item: putinTableView!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: putinTableView!, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: putinTableView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 0.9, constant: 0),
            NSLayoutConstraint(item: putinTableView!, attribute: .top, relatedBy: .equal, toItem: squareView, attribute: .bottom, multiplier: 1, constant: 0)
        ]
        //Активирую констраинтсы
        NSLayoutConstraint.activate(putinTableViewConstraints)
    }
}
//MARK: - TableViewDataSource

//Когда я обозначил Data Source во время сетапа Table View, свифт автоматически предложил мне конформить протоколу UITableViewDataSource - мне осталось только перенести его в отдельный Extension для лучшего чтения - захламлять код я могу только своими комментариями.

extension ViewController: UITableViewDataSource {
    //Сколько мне нужно рядов для моих клеток?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //SECTION.COUNT
        putinSquadUnit[]
    }
    //Какие клетки я буду вставлять в эти ряды? В конце функции я обязан выдать (объект?) формата UITableViewCell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Когда используешь dequeReusableCell, а эта клетка является классом(который ты зарегистрировал выше в TableView), то функция deque обращается к функции Init класса клетки. Поэтому важно делать override init и там вызывать все методы, которые есть. Почему Init в классе выглядит именно так, как он выглядит, я все еще не понимаю.
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PutinSquadCellIdentifier", for: indexPath) as? PutinSquadCell
        
        // Создаю константу с тайтлом из массива для каждого отдельного ряда, ведь у меня есть функция configure в моей зарегистрированной клетке. А чтобы ее вызвать, мне как раз нужен тайтл. (можно и без константы это делать, но так код выглядит понятнее.)
        let putinSquadUnitTitle =
        let picture =
        // Обращаюсь к публичной функции configure для установки правильного String в моем Label
        cell?.configure(title: putinSquadUnitTitle, picture: picture)
        //Возвращаю Unwrapped клетку, как того и требует функция протокола.
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        putinSquadUnit.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        putinSquadUnit
    }
}
//MARK: - SetupDestroyAllButton

extension ViewController{
    func setupButton () {
        button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("УНИЧТОЖИТЬ ВСЕХ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let buttonContsratins = [
            NSLayoutConstraint(item: button!, attribute: .top, relatedBy: .equal, toItem: putinTableView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 75),
            NSLayoutConstraint(item: button!, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button!, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        ]
        
        NSLayoutConstraint.activate(buttonContsratins)
    }
    
    @objc func buttonAction(sender: UIButton!) {
      setUpLocationDelegate()
    }
}
//MARK: - locationDelegate
extension ViewController: CLLocationManagerDelegate{
    func setUpLocationDelegate() {
        //Создаю объект из класса Локейшн Менеджер
        locationManager = CLLocationManager()
        //Он Будет сам себе указывать, что делать
        locationManager?.delegate = self
        //Попросит разрешения Взять Локацию
        locationManager?.requestWhenInUseAuthorization()
        //Если Запрещена Локейшн - сразу нужен АЛЕРТ!
            if CLLocationManager.locationServicesEnabled(){
        print("This one works")
        //Если не запрещено, то возьмет Локацию
                if locationManager?.authorizationStatus != CLAuthorizationStatus.denied{
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        print("За Вами Выехали")
    }
        // А если запрещено, то покажет Алерт!
                else {
            locationAlert(alertTitle: "Укажите на карте, если вы против беспредела!", alertMessage: "Уже \(randomNumber) человека с нами!")
        }
        }
            else{
            locationAlert(alertTitle: "Вместе Мы Сила!", alertMessage: "Включите геолокацию, чтобы увидеть соратников!")
        }
    }
    //Относится к протоколу? К чему относится?
    //Если получил локацию, то запринть её и добавь ЛАТ И ЛОН данные - Позже брать инфу из API для указания города.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            print(location)
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
    }
    
    //Украдено со Stack Overflow, непонятно, зачем оно нужно в моем коде.
  /*  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager, status: CLAuthorizationStatus) {
        if status != CLAuthorizationStatus.authorizedAlways{
            locationAlert()
        }
    }
 */
    //Алерт тоже украл, понял процентов 65 этого кода. Не понимаю, как работает Open Action.
    func locationAlert(alertTitle:String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle , message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let openAction = UIAlertAction(title: "Open Setting", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString){ UIApplication.shared.open(url, options: [:], completionHandler: nil)}
                }
                alertController.addAction(openAction)
                self.present(alertController, animated: true, completion: nil)
        randomNumber += Int.random(in: 0...7)
    }
}


