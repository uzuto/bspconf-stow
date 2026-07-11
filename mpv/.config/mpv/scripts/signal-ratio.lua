function check_chapter_timeline()
    local title = mp.get_property("chapter-metadata/title")
    if title then
        if string.find(title, "PAST") then -- "%[PAST%]"
            mp.set_property("video-aspect-override", "2.35:1")
        elseif string.find(title, "PRESENT") then -- "%[PRESENT%]"
            mp.set_property("video-aspect-override", "16:9")
        end
    end
end

mp.observe_property("chapter", "number", check_chapter_timeline)
mp.register_event("file-loaded", check_chapter_timeline)
