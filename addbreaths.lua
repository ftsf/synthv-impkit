function getClientInfo()
    return {
        name = "Add Breaths",
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
        local newNotes = {}
        sel:clearAll()
        for i=1, #notes do
            local note = notes[i]
            local group = note:getParent()
            local i = note:getIndexInParent()

            local duration = SV.QUARTER

            if i > 1 then
                local prevNote = group:getNote(i-1)
                if prevNote ~= nil then
                    duration = note:getOnset() - prevNote:getEnd()
                end
            end

            if duration > 0 then
                local newNote = SV:create("Note")
                newNote:setOnset(note:getOnset() - duration)
                newNote:setPitch(note:getPitch())
                newNote:setDuration(duration)
                newNote:setLyrics("br")
                group:addNote(newNote)
                sel:selectNote(newNote)
            end
        end
    end
    SV:finish()
end
