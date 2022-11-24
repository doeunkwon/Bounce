//
//  scheduleViewController.swift
//  Bounce
//
//  Created by Doeun Kwon on 2022-10-07.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    let coreDataManager = CoreDataManager()
    
    @IBOutlet weak var scheduleTableView: UITableView!
    
    var eventArray = [Event]()
    var preferenceArray = [Preference]()
    var scheduleArray = [Schedule]()
    
    var startingTime = Int()
    var clock = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreDataManager.loadSchedule(&scheduleArray)
        coreDataManager.loadPreference(&preferenceArray)
        coreDataManager.loadEvents(&eventArray)
        
        scheduleTableView.dataSource = self
        
        scheduleTableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "reusableCell")
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)

        if hour == 23 {
            startingTime = 23
        } else {
            startingTime = hour + 1
        }
        
        var newDay = true
        
        if scheduleArray.count > 0 {
            /// arbitrarily picks 1st as test
            if let originDate = scheduleArray[0].origin {
                /// converts Date() type into comparable date form regardless of time
                let originID = originDate.description.split(separator: " ")[0].split(separator: "-").joined()
                let todayID = date.description.split(separator: " ")[0].split(separator: "-").joined()
                if todayID <= originID {
                    newDay = false
                }
            }
        }

        /// uncomment for testing
        startingTime = 11
        newDay = true
        
        if newDay {
            for schedule in scheduleArray {
                coreDataManager.delete(schedule)
            }
            scheduleArray = []
            coreDataManager.save()
            
            generateSchedule()
            addBedtime()
        }

    }
    
    func generateSchedule() {
        let early = eventArray.filter { event in
            return event.day == 0
        }
        let noon = eventArray.filter { event in
            return event.day == 1
        }
        let late = eventArray.filter { event in
            return event.day == 2
        }
        
        /// early is 1am - 10am, noon is 11am - 4pm, late is 5pm - 11pm
        let phaseArray = [early, noon, late]
        
        for i in 0 ... 2 {
            var rem = 0
            if i == 0 {
                rem += 10
            } else if i == 1 {
                rem += 6
                clock = 11
            } else {
                rem += 8
                clock = 17
                if preferenceArray.count > 0 {
                    rem = Int(preferenceArray[0].bed - 17)
                }
            }
            updateTime(&rem)
            let phase = phaseArray[i].shuffled()
            
            for event in phase {
                if rem <= 0 {
                    break
                }
                if event.time <= rem {
                    rem -= Int(event.time)
                    addToSchedule(event)
                }
            }
        }
    }
    
    func updateTime(_ rem: inout Int) {
        if startingTime > 0 {
            clock += startingTime
            let temp = rem
            rem -= startingTime
            startingTime -= temp
        }
    }
    
    func addToSchedule(_ event: Event) {
        let newSchedule = Schedule(context: coreDataManager.context)
        newSchedule.event = event.event
        newSchedule.time = event.time
        newSchedule.origin = Date()
        newSchedule.clock = Int32(clock)
        coreDataManager.save()
        scheduleArray.append(newSchedule)
        clock = clock + Int(event.time)
    }
    
    func addBedtime() {
        if preferenceArray.count > 0 {
            let newSchedule = Schedule(context: coreDataManager.context)
            newSchedule.event = "bed 🛏️"
            newSchedule.time = preferenceArray[0].sleep
            newSchedule.origin = Date()
            newSchedule.clock = preferenceArray[0].bed
            coreDataManager.save()
            self.scheduleArray.append(newSchedule)
        }
    }
}

//MARK: - UITableViewDataSource

extension ScheduleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! EventCell
        cell.eventLabel.text = "\(scheduleArray[indexPath.row].event!)"
        if scheduleArray[indexPath.row].clock == 12 {
            cell.infoLabel.text = "\(scheduleArray[indexPath.row].clock):00pm"
        } else if scheduleArray[indexPath.row].clock > 12 {
            cell.infoLabel.text = "\(scheduleArray[indexPath.row].clock - 12):00pm"
        } else {
            cell.infoLabel.text = "\(scheduleArray[indexPath.row].clock):00am"
        }
        return cell
    }
    
}
