local function format_time(seconds)
    local hours = math.floor(seconds / 3600)
    local mins = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    local msecs = math.floor((seconds - math.floor(seconds)) * 1000)
    
    -- Format HH:MM:SS.mmm
    return string.format("%02d:%02d:%02d.%03d", hours, mins, secs, msecs)
end

mp.add_key_binding("v", "log_timestamp", function()
    local time = mp.get_property_number("time-pos", 0)
    local video_path = mp.get_property("path")
    
    if not video_path then
        mp.osd_message("Error: No video file path found")
        return
    end

    local log_path = video_path .. "-time.txt"
    local formatted_timestamp = format_time(time)

    local file = io.open(log_path, "a")
    if file then
        file:write(formatted_timestamp .. "\n")
        file:close()
        mp.osd_message("Logged: " .. formatted_timestamp)
    else
        mp.osd_message("Error: Could not write to file")
    end
end)
