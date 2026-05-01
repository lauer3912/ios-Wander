import Foundation
import UserNotifications

class NotificationService {

    static let shared = NotificationService()

    private let center = UNUserNotificationCenter.current()
    private let dailyReminderID = "com.ggsheng.Wander.dailyReminder"

    private init() {}

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
            DispatchQueue.main.async { completion(granted) }
        }
    }

    func scheduleDailyStrangerReminder() {
        center.removePendingNotificationRequests(withIdentifiers: [dailyReminderID])

        let content = UNMutableNotificationContent()
        content.title = "🌟 Wander"
        content.body = "A stranger is waiting to meet you. Open Wander and start a conversation."
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: DateComponents(hour: 20, minute: 0),
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: dailyReminderID,
            content: content,
            trigger: trigger
        )

        center.add(request) { error in
            if let e = error { print("Notification error: \(e)") }
        }
    }

    func cancelAll() {
        center.removePendingNotificationRequests(withIdentifiers: [dailyReminderID])
    }

    var isEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "Wander.notificationsEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "Wander.notificationsEnabled") }
    }

    func toggle(enabled: Bool, completion: @escaping (Bool) -> Void) {
        if enabled {
            requestAuthorization { [weak self] granted in
                if granted {
                    self?.isEnabled = true
                    self?.scheduleDailyStrangerReminder()
                    completion(true)
                } else { completion(false) }
            }
        } else {
            isEnabled = false
            cancelAll()
            completion(true)
        }
    }

    func restoreScheduledNotifications() {
        if isEnabled { scheduleDailyStrangerReminder() }
    }
}
