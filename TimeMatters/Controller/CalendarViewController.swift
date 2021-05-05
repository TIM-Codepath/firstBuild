//
//  CalendarViewController.swift
//  TimeMatters
//
//  Created by Chhoden Sherpa on 4/20/21.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.showsVerticalScrollIndicator = false
        self.calendarView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: false, preferredScrollPosition: .right, extraAddedOffset: 0, completionHandler: nil)
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
           print("Selected")
            } else {
            
            }
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
