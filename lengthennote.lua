function getClientInfo()
    return {
        name = "Lengthen Note",
        author = "impbox",
        versionNumber = 1,
        minEditorVersion = 0
    }
end

function getTranslations(langCode)
    -- please help add translations <3
    return {}
end

function main()
    local sel = SV:getMainEditor():getSelection()
    if sel ~= nil then
        local notes = sel:getSelectedNotes()
        if #notes > 0 then
            local group = notes[#notes]:getParent()
            local lastIndex = notes[#notes]:getIndexInParent()
            local afterNote = nil
            if group:getNumNotes() > lastIndex then
                if group:getNote(lastIndex+1):getOnset() == group:getNote(lastIndex):getEnd() then
                    afterNote = group:getNote(lastIndex+1)
                end
            end
            if afterNote ~= nil then
                -- calculate how much space we need
                local addSpace = 0
                for i=1, #notes do
                    addSpace = addSpace + notes[i]:getDuration()
                end
                afterNote:setOnset(afterNote:getOnset() + addSpace)
            end
            for i=1, #notes do
                -- lengthen note
                local note = notes[i]
                local nextNote = nil
                if i+1 <= #notes and notes[i+1]:getOnset() == notes[i]:getEnd() then
                    nextNote = notes[i+1]
                end
                note:setDuration(note:getDuration()*2)
                if nextNote ~= nil then
                    nextNote:setOnset(note:getEnd())
                end
            end
        end
    end
    SV:finish()
end
