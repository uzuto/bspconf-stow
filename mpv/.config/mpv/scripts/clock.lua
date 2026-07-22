-- Shows real-world system clock on mouse move (Customizable Text & Position)
local hide_timer = nil
local clock_overlay = mp.create_osd_overlay("ass-events")

-- CONFIGURATION
local font_size = 50          -- Increase/decrease font size
local font_name = "sans-serif"-- Change font family (e.g. "GandhiSans-Bold")
local use_bold  = true       -- Set to true for bold, false for normal weight
local position  = "top-right" -- Options: "top-right", "top-left", "bottom-right", "bottom-left", "center"
local margin    = 25          -- Margin in pixels from screen edges

-- Alignment mapping (ASS numpad alignment: 9=top-right, 7=top-left, 3=bottom-right, 1=bottom-left, 5=center)
local align_map = {
    ["top-right"]    = "{\\an9}",
    ["top-left"]     = "{\\an7}",
    ["bottom-right"] = "{\\an3}",
    ["bottom-left"]  = "{\\an1}",
    ["center"]       = "{\\an5}"
}

local function show_clock()
    local time_str = os.date("%H:%M:%S")
    local bold_tag = use_bold and "{\\b1}" or "{\\b0}"
    local align_tag = align_map[position] or "{\\an9}"
    
    -- Format ASS string with explicit font settings and margins
    clock_overlay.data = string.format(
        "%s{\\q2}{\\fn%s}{\\fs%d}%s{\\margh%d}{\\margv%d}%s",
        align_tag,
        font_name,
        font_size,
        bold_tag,
        margin,
        margin,
        time_str
    )
    clock_overlay:update()
end

mp.observe_property("mouse-pos", "native", function(_, val)
    if not val then return end

    show_clock()

    if hide_timer then
        hide_timer:kill()
    end

    hide_timer = mp.add_timeout(0.5, function()
        clock_overlay:remove()
    end)
end)
