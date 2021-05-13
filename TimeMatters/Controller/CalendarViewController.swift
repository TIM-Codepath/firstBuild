//
//  CalendarViewController.swift
//  TimeMatters
//
//  Created by Chhoden Sherpa on 4/20/21.
//

import UIKit
import JTAppleCalendar
import Parse

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CalendarDelegate {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBarButton()
        tableView.delegate = self
        tableView.dataSource = self
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.showsVerticalScrollIndicator = false
        calendarView.selectDates([Date()])
        self.calendarView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: false, preferredScrollPosition: .right, extraAddedOffset: 0, completionHandler: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getTasks()
    }
    
    func initBarButton() {
        let button = UIButton(type: .system)
        button.setTitle("Add Task", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(17)
        button.addTarget(self, action: #selector(clickAddTask), for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: button), animated: true)
    }
    
    @objc func clickAddTask() {
        let storyboard: UIStoryboard = UIStoryboard(name: "ProductivityStoryboard", bundle:nil)
        let view  = storyboard.instantiateViewController(withIdentifier: "calendarPopUp") as! CalendarPopUpViewController
        view.date = calendarView.selectedDates[0].description
        view.delegate = self
        view.modalPresentationStyle = .overFullScreen
        self.present(view, animated: false, completion: nil)
    }
    
    func configureCell(view: JTAppleCell?, cellState: CellState) {
       guard let cell = view as? DateCell  else { return }
       cell.dateLabel.text = cellState.text
       handleCellTextColor(cell: cell, cellState: cellState)
       handleCellSelected(cell: cell, cellState: cellState)
    }
        
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
       if cellState.dateBelongsTo == .thisMonth {
          cell.dateLabel.textColor = UIColor.label
       } else {
          cell.dateLabel.textColor = UIColor.gray
       }
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  14
            cell.selectedView.isHidden = false
            getTasks()
        } else {
            cell.selectedView.isHidden = true
        }
    }
    
    func getTasks() {
        let query = PFQuery(className: "CalendarTask")
        query.includeKeys(["task_name"])
        query.whereKey("username", contains: PFUser.current()?.username)
        query.whereKey("date", contains: calendarView.selectedDates[0].description)
        query.findObjectsInBackground { (tasks, error) in
            if tasks != nil {
                self.tasks = tasks!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = UITableViewCell()
        if let taskName = task["task_name"] as? String {
            cell.textLabel?.text = taskName
        }
        return cell
    }
}

extension CalendarViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2018 01 01")!
        let endDate = formatter.date(from: "2050 12 31")!
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

extension CalendarViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
       let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
       self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
       return cell
    }
        
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
       configureCell(view: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }

    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(view: cell, cellState: cellState)
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "MMM YYYY"
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = formatter.string(from: range.start)
        return header
    }

    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
}

protocol CalendarDelegate {
    func getTasks()
}
