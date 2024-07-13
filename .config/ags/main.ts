import { applauncher } from "widgets/applauncher"
import { bar } from "widgets/bar"
import { media } from "widgets/media"
import { NotificationPopups } from "widgets/notification"

App.config({
    style: App.configDir + "/styles/notification.css",
    windows: [applauncher, bar, media, NotificationPopups()]
})


