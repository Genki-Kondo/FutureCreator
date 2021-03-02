//
//  EventCalenderViewController.swift
//  FutureCreator
//
//  Created by 近藤元気 on 2020/09/20.
//  Copyright © 2020 genkikondo. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift
import EMTNeumorphicView

class ShowCalenderViewController: UIViewController,FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance,UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    @IBOutlet var addContextButton: EMTNeumorphicView!
    @IBOutlet var tableview: UITableView!
    
    //スケジュール内容
    
    @IBOutlet var memoLabel: UILabel!
    
    //カレンダー部分
    @IBOutlet var dateView: FSCalendar!
    //「主なスケジュール」の表示
    @IBOutlet var labelTitle: UILabel!
    //日付の表示
    @IBOutlet var showDate: UILabel!
    
    //カレンダーが選択された時の日時を一時保管する為の変数
    var carendarTime = ""
    var datesWithEvents: Set<String> = []
    //tableviewに表示される学習記録の情報を一時入れる為
    var studyTypeArray:[String] = []
    var studyLanguageArray:[String] = []
    var studyTimeArray:[String] = []
    var floatButton = FloatButton()
    var touchCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        floatButton.changeButton(button: addContextButton)

        tableview.register(UINib(nibName: "SavedCustumCell", bundle: nil), forCellReuseIdentifier: "SavedCustumCell")
        
        //delegateの宣言
        tableview.delegate = self
        tableview.dataSource = self
        //        realmMigration()
        //カレンダー設定
        self.dateView.dataSource = self
        self.dateView.delegate = self
        self.dateView.appearance.todayColor = UIColor.systemRed
        self.dateView.tintColor = .red
        self.view.backgroundColor = .white
        dateView.backgroundColor = .white
        
        
        //日付表示設定
        showDate.text = ""
        
        
        //「主なスケジュール」表示設定
        labelTitle.text = ""
        labelTitle.textAlignment = .center
        
        
        //スケジュール内容表示設定
        memoLabel.text = ""
        
        //        view.addSubview(labelDate)
        //学習の種類
        //        studyTypeLabel.text = ""
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableview.reloadData()
        dateView.reloadData()
    }
    //カレンダーの設定
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    // 祝日判定を行い結果を返すメソッド
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)
        
        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }
    
    //曜日判定
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }
    
    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする
        if self.judgeHoliday(date){
            return UIColor.red
        }
        
        //土日の判定
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {
            return UIColor.red
        }
        else if weekday == 7 {
            return UIColor.blue
        }
        
        return nil
    }
    // 任意の日付に点マークをつける
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int{
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        let calendarDay = formatter.string(from: date)
        
        // Realmオブジェクトの生成
        let realm = try! Realm()
        // 参照（全データを取得）
        let resultPoint = realm.objects(Study.self)
        
        if resultPoint.count > 0 {
            for i in 0..<resultPoint.count {
                if i == 0 {
                    datesWithEvents = [resultPoint[i].studyDate]
                } else {
                    datesWithEvents.insert(resultPoint[i].studyDate)
                }
            }
        } else {
            datesWithEvents = []
        }
        
        
        return datesWithEvents.contains(calendarDay) ? 1 : 0
    }
    //カレンダー処理(スケジュール表示処理)
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
        //tableviewの更新
        tableview.reloadData()
        labelTitle.text = "主なスケジュール"
        labelTitle.backgroundColor = .orange
        //予定がある場合、スケジュールをDBから取得・表示する。
        //無い場合、「スケジュールはありません」と表示。
        memoLabel.text = "スケジュールはありません"
        memoLabel.textColor = .lightGray
        //        studyTypeLabel.text = ""
        //        studyLanguageLabel.text = ""
        //        studyTimeLabel.text = ""
        
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        
        let da = "\(year)/\(m)/\(d)"
        carendarTime = da
        //クリックしたら、日付が表示される。
        showDate.text = "\(m)/\(d)"
        
        //格納された配列の要素を一度リセット
        studyTypeArray.removeAll()
        studyLanguageArray.removeAll()
        studyTimeArray.removeAll()
        //カレンダーの出来事欄に記入
        var resultMemo = realm.objects(Event.self)
        resultMemo = resultMemo.filter("date = '\(da)'")
        print(resultMemo)
        for ev in resultMemo {
            if ev.date == da {
                
                memoLabel.text = ev.event
                memoLabel.textColor = .black
                
                print("メモに記入")
            }
        }
        
        
        //tableviewの更新
        tableview.reloadData()
    }
    //cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnNum = 0
        var resultStudyCount = realm.objects(Study.self)
        resultStudyCount = resultStudyCount.filter("studyDate = '\(carendarTime)'")
        for st in resultStudyCount {
            if st.studyDate == carendarTime {
                returnNum = resultStudyCount.count
            }
        }
        return returnNum
    }
    //cellの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCustumCell", for: indexPath) as! SavedCustumCell
        
        
        
        
        //配列の要素を反転させる
        studyTypeArray.reverse()
        studyLanguageArray.reverse()
        studyTimeArray.reverse()
        
        cell.studyTypeLabel.text = ""
        cell.studyLanguageLabel.text = ""
        cell.studyTimeLabel.text = ""
        //レルムをインスタンス化
        var resultCell = realm.objects(Study.self)
        resultCell = resultCell.filter("studyDate = '\(carendarTime)'")
        print(resultCell)
        
        for st in resultCell {
            if st.studyDate == carendarTime {
                
                //配列に追加
                studyTypeArray.append(st.studyType)
                studyLanguageArray.append(st.studyLaunguage)
                studyTimeArray.append(String(st.studyHours))
                
                
                //cellに貼り付け
                cell.studyTypeLabel.text = studyTypeArray[indexPath.row]
                cell.studyLanguageLabel.text = studyLanguageArray[indexPath.row]
                cell.studyTimeLabel.text = studyTimeArray[indexPath.row]
                
                print(studyTypeArray)
                print(studyLanguageArray)
                print(studyTimeArray)
                print("学習記録を記入")
            }
        }
        
        return cell
    }
    //内容追加に画面遷移
    @IBAction func toEvent(_ sender: Any) {
        performSegue(withIdentifier: "toEvent", sender: nil)
    }
    //画面遷移する際に値を保持
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEvent" {
            
            
            let eventView = segue.destination as! EventViewController
            
            
            eventView.calenderTime = carendarTime
        }
    }
    
    //cellが左にスワイプされた時にカレンダーから削除するメソッド
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "カレンダーから削除") { [self] (action, index) -> Void in

            var studyRealm = realm.objects(Study.self)
            var resultStudyDate = studyRealm.filter("studyDate == '\(carendarTime)'")
       
            try! realm.write{
                
                realm.delete(resultStudyDate[indexPath.row])

                
            }
            tableview.reloadData()

        }
        deleteButton.backgroundColor = UIColor.blue
        return [deleteButton]

    }
    
}

