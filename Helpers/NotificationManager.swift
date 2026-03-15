import UserNotifications

class NotificationManager {

    static let shared = NotificationManager()

    // MARK: - Notification Schedule
    private let schedule: [(id: String, hour: Int, minute: Int, title: String, body: String)] = [
        (
            id: "calm_morning",
            hour: 8, minute: 0,
            title: "Good morning.",
            body: "Start your day with 2 minutes of calm."
        ),
        (
            id: "calm_afternoon",
            hour: 12, minute: 30,
            title: "Midday reset.",
            body: "Step away for 2 minutes. You've earned it."
        ),
        (
            id: "calm_evening",
            hour: 17, minute: 0,
            title: "Wind down time.",
            body: "Take 2 minutes before the evening rush."
        ),
        (
            id: "calm_night",
            hour: 21, minute: 0,
            title: "Before you sleep.",
            body: "End your day with 2 minutes of stillness."
        )
    ]

    // MARK: - Request Permission
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { granted, error in
            if granted {
                self.scheduleAllNotifications()
            }
        }
    }

    // MARK: - Schedule All 4 Notifications
    private func scheduleAllNotifications() {

        // Clear all existing calm notifications first
        let ids = schedule.map { $0.id }
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: ids)

        // Schedule each one
        for item in schedule {
            let content = UNMutableNotificationContent()
            content.title = item.title
            content.body  = item.body
            content.sound = .default

            var dateComponents    = DateComponents()
            dateComponents.hour   = item.hour
            dateComponents.minute = item.minute

            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents,
                repeats: true
            )

            let request = UNNotificationRequest(
                identifier: item.id,
                content: content,
                trigger: trigger
            )

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Notification error [\(item.id)]: \(error.localizedDescription)")
                }
            }
        }
    }

    // MARK: - Cancel All Notifications
    func cancelAllNotifications() {
        let ids = schedule.map { $0.id }
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: ids)
    }
}
