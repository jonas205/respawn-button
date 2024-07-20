local mod_gui = require("mod-gui")

local GUI_BUTTON = "re-button"

local function get_re_flow(player)
    local button_flow = mod_gui.get_button_flow(player)
    local flow = button_flow.re_flow
    if not flow then
        flow = button_flow.add {
            type = "flow",
            name = "re_flow",
            direction = "horizontal"
        }
    end
    return flow
end

local function add_top_button(player)
    if player.gui.top.re_flow then player.gui.top.re_flow.destroy() end
    local flow = get_re_flow(player)

    if flow[GUI_BUTTON] then flow[GUI_BUTTON].destroy() end
    flow.add {
        type = "sprite-button",
        name = GUI_BUTTON,
        sprite = "respawn-sprite",
        style = mod_gui.button_style,
        tooltip = { "respawn-button-tooltip" }
    }
end


script.on_init(function()
    for _, player in pairs(game.players) do
        add_top_button(player)
    end
end)

script.on_event(defines.events.on_player_created, function(event)
    local player = game.players[event.player_index]
    add_top_button(player)
end)

local function respawn(player)
    local char = player.character

    if char ~= nil then
        char.die()
    else
        player.print("No Player Character Found")
    end
end

script.on_event(defines.events.on_gui_click, function(event)
    if event.element.name == GUI_BUTTON then
        local player = game.players[event.player_index]
        respawn(player)
    end
end)
