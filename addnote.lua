function getClientInfo()
    return {
        name = "Add Note",
        author = "impbox",
        versionNumber = 1,
        minEditorVersion = 0
    }
end

function getTranslations(langCode)
    -- please help add translations <3
    return {}
end

-- Wrapper function to know the flow of code
function main()
    local sel = SV:getMainEditor():getSelection()
    if sel ~= nil then
        local notes = sel:getSelectedNotes()
        if #notes > 0 then
            local lastSelectedNote = notes[#notes]
            local group = lastSelectedNote:getParent()
            local i = lastSelectedNote:getIndexInParent()
            local lastNote = group:getNote(i)
            local note = lastNote:clone()
            note:setOnset(lastNote:getEnd())
            note:setPitch(lastNote:getPitch())
            note:setDuration(lastNote:getDuration())
            note:setLyrics(lastNote:getLyrics())
            group:addNote(note)
            sel:clearAll()
            sel:selectNote(note)
        else
            local group = SV:getMainEditor():getCurrentGroup()
            if group then
                local note = SV:create("Note")
                note:setOnset(group:getEnd())
                note:setPitch(60)
                note:setDuration(SV.QUARTER)
                note:setLyrics("la")
                group:getTarget():addNote(note)
                sel:clearAll()
                sel:selectNote(note)
            end
        end
    end
    SV:finish()
end
