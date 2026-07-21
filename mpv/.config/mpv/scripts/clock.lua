-- Shows real-world system clock on mouse move (Customizable Text & Position)
local hide_timer = nil

-- CONFIGURATION
local font_size = 25          -- Increase/decrease font size (default is ~36)
local use_bold  = false        -- Set to true for bold, false for normal weight
local position  = "top-right" -- Options: "top-right", "top-left", "bottom-right", "bottom-left", "center"

-- Alignment mapping (ASS numpad alignment: 9=top-right, 7=top-left, 3=bottom-right, 1=bottom-left, 5=center)
local align_map = {
    ["top-right"]    = "{\\an9}",
    ["top-left"]     = "{\\an7}",
    ["bottom-right"] = "{\\an3}",
    ["bottom-left"]  = "{\\an1}",
    ["center"]       = "{\\an5}"
}

local function show_clock()
    local ass_start = mp.get_property("osd-ass-cc/0")
    local ass_stop  = mp.get_property("osd-ass-cc/1")
    
    local time_str = os.date("%H:%M:%S")
    local bold_tag = use_bold and "{\\b1}" or "{\\b0}"
    local align_tag = align_map[position] or "{\\an9}"
    
    -- Combines Alignment + Font Size + Bold + Time
    local formatted_text = string.format("%s%s{\\fs%d}%s %s %s", ass_start, align_tag, font_size, bold_tag, time_str, ass_stop)
    
    mp.osd_message(formatted_text, 0.5)
end

mp.observe_property("mouse-pos", "native", function(_, val)
    if not val then return end

    show_clock()

    if hide_timer then
        hide_timer:kill()
    end

    hide_timer = mp.add_timeout(1.0, function()
        mp.osd_message("", 0)
    end)
end)
