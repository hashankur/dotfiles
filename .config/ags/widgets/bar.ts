const notifications = await Service.import("notifications")
const mpris = await Service.import("mpris")
const audio = await Service.import("audio")
const battery = await Service.import("battery")
const systemtray = await Service.import("systemtray")

const date = Variable("", {
    poll: [1000, 'date "+%a%n%d%n%b%n%n%I%n%M%n%p"'], // Woops
})

function Clock() {
    return Widget.Label({
        class_name: "clock",
        css: "margin: 1rem;",
        label: date.bind(),
        justification: "center"
    })
}


function Notification() {
    const popups = notifications.bind("popups")
    return Widget.Box({
        class_name: "notification",
        visible: popups.as(p => p.length > 0),
        children: [
            Widget.Icon({
                icon: "preferences-system-notifications-symbolic",
            }),
            Widget.Label({
                label: popups.as(p => p[0]?.summary || ""),
            }),
        ],
    })
}


function Media() {
    const label = Utils.watch("", mpris, "player-changed", () => {
        if (mpris.players[0]) {
            const { track_artists, track_title } = mpris.players[0]
            return `${track_artists.join(", ")} - ${track_title}`
        } else {
            return "Nothing is playing"
        }
    })

    return Widget.Button({
        class_name: "media",
        on_primary_click: () => mpris.getPlayer("")?.playPause(),
        on_scroll_up: () => mpris.getPlayer("")?.next(),
        on_scroll_down: () => mpris.getPlayer("")?.previous(),
        child: Widget.Label({ label }),
    })
}


function Volume() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    }

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100)

        return `audio-volume-${icons[icon]}-symbolic`
    }

    const icon = Widget.Icon({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    })

    const slider = Widget.Slider({
        hexpand: true,
        draw_value: false,
        on_change: ({ value }) => audio.speaker.volume = value,
        setup: self => self.hook(audio.speaker, () => {
            self.value = audio.speaker.volume || 0
        }),
    })

    return Widget.Box({
        class_name: "volume",
        css: "margin: 1rem",
        hpack: "center",
        children: [icon],
    })
}


function BatteryLabel() {
    const value = battery.bind("percent").as(p => p > 0 ? p / 100 : 0)
    const icon = battery.bind("percent").as(p =>
        `battery-level-${Math.floor(p / 10) * 10}-symbolic`)

    return Widget.Box({
        class_name: "battery",
        css: "margin: 1rem",
        visible: battery.bind("available"),
        hpack: "center",
        children: [
            Widget.Icon({ icon }),
            // Widget.LevelBar({
            //     widthRequest: 140,
            //     vpack: "center",
            //     value,
            // }),
        ],
    })
}


function SysTray() {
    const items = systemtray.bind("items")
        .as(items => items.map(item => Widget.Button({
            child: Widget.Icon({ icon: item.bind("icon") }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind("tooltip_markup"),
            css: "background: none;",
        })))

    return Widget.Box({
        children: items,
        vertical: true
    })
}
const Top = () => { }

const Center = () => {
    return Widget.Box({
        hpack: "center",
        vertical: true,
        children: [
            // Media(),
            // Notification(),
        ],
    })
}
const Bottom = () => {
    return Widget.Box({
        hpack: "center",
        vpack: "end",
        vertical: true,
        children: [
            SysTray(),
            Volume(),
            BatteryLabel(),
            Clock(),
        ],
    })
}

export const bar = Widget.Window({
    name: "bar",
    anchor: ["top", "right", "bottom"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
        // start_widget: Top(),
        center_widget: Center(),
        end_widget: Bottom(),
        class_name: "bar",
        vertical: true
    }),
})
