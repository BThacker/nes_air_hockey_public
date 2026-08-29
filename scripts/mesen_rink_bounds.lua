-- Air Hockey NES — Mesen rink-boundary overlay
--
-- Load from Mesen's Script Window. The overlay redraws every frame and does
-- not read or modify emulator memory.

local RINK = {
    left_x = 72,
    right_x = 184,
    top_y = 24,
    bottom_y = 216,
    left_net_x = 105,
    right_net_x = 150,
}

local PUCK_RADIUS = 4
local SCREEN_TOP = 0
local SCREEN_BOTTOM = 239

local OUTER_WALL_COLOR = 0x00FF00
local GOAL_POST_COLOR = 0xFF00FF
local PUCK_CENTER_LIMIT_COLOR = 0xFFFF00
local SCORE_LINE_COLOR = 0x00FFFF

local function draw_line(x1, y1, x2, y2, color)
    emu.drawLine(x1, y1, x2, y2, color, 2)
end

local function draw_rink_bounds()
    emu.selectDrawSurface(emu.drawSurface.consoleScreen)
    emu.drawString(2, 2, "RINK DEBUG", 0xFFFFFF, 0, 0, 2)

    local goal_left_center = RINK.left_net_x + PUCK_RADIUS
    local goal_right_center = RINK.right_net_x - PUCK_RADIUS

    -- Solid outer rink walls, excluding the two goal openings.
    draw_line(RINK.left_x, RINK.top_y, RINK.left_x, RINK.bottom_y, OUTER_WALL_COLOR)
    draw_line(RINK.right_x, RINK.top_y, RINK.right_x, RINK.bottom_y, OUTER_WALL_COLOR)
    draw_line(RINK.left_x, RINK.top_y, RINK.left_net_x, RINK.top_y, OUTER_WALL_COLOR)
    draw_line(RINK.right_net_x, RINK.top_y, RINK.right_x, RINK.top_y, OUTER_WALL_COLOR)
    draw_line(RINK.left_x, RINK.bottom_y, RINK.left_net_x, RINK.bottom_y, OUTER_WALL_COLOR)
    draw_line(RINK.right_net_x, RINK.bottom_y, RINK.right_x, RINK.bottom_y, OUTER_WALL_COLOR)

    -- Physical goal-post faces from RINK_DIMENSIONS.
    draw_line(RINK.left_net_x, SCREEN_TOP, RINK.left_net_x, RINK.top_y, GOAL_POST_COLOR)
    draw_line(RINK.right_net_x, SCREEN_TOP, RINK.right_net_x, RINK.top_y, GOAL_POST_COLOR)
    draw_line(RINK.left_net_x, RINK.bottom_y, RINK.left_net_x, SCREEN_BOTTOM, GOAL_POST_COLOR)
    draw_line(RINK.right_net_x, RINK.bottom_y, RINK.right_net_x, SCREEN_BOTTOM, GOAL_POST_COLOR)

    -- Puck-center limits after accounting for the 4-pixel puck radius.
    draw_line(goal_left_center, SCREEN_TOP, goal_left_center, RINK.top_y, PUCK_CENTER_LIMIT_COLOR)
    draw_line(goal_right_center, SCREEN_TOP, goal_right_center, RINK.top_y, PUCK_CENTER_LIMIT_COLOR)
    draw_line(goal_left_center, RINK.bottom_y, goal_left_center, SCREEN_BOTTOM, PUCK_CENTER_LIMIT_COLOR)
    draw_line(goal_right_center, RINK.bottom_y, goal_right_center, SCREEN_BOTTOM, PUCK_CENTER_LIMIT_COLOR)

    -- A goal is scored when the puck center crosses one of these segments.
    draw_line(goal_left_center, RINK.top_y, goal_right_center, RINK.top_y, SCORE_LINE_COLOR)
    draw_line(goal_left_center, RINK.bottom_y, goal_right_center, RINK.bottom_y, SCORE_LINE_COLOR)
end

emu.selectDrawSurface(emu.drawSurface.consoleScreen)
-- Visible for ten seconds after loading; verifies that emu.drawLine is active.
emu.drawLine(0, 0, 255, 239, 0xFF0000, 600)
emu.addEventCallback(draw_rink_bounds, emu.eventType.endFrame)
emu.displayMessage("Rink Bounds", "Overlay loaded: green walls, magenta posts, yellow puck limits, cyan score lines.")
