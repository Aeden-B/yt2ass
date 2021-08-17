local tr = aegisub.gettext

script_name = tr"Youtube Converter"
script_description = tr"Convert youtube ass to karaoke ass"
script_author = "aeden"
script_version = "1.7"

balise = "{\\c\\?c?&%w+&}"

-- note regexp for delete all style balise (?!{\\c&HD9D9D9&}){[^}]*}

function string.starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
 end

function convert_line(subs, sel)
    beforetext = nil
    todelete = {}
    texttoadd = ""
    start_time = nil
    for _, i in ipairs(sel) do
        line = subs[i]
        match = line.text:match("%s[^{%s]*%s".. balise) -- space / punctuation (0 or 1) / letters (1 or more) / punctuation (0 or 1) / letters (0 or more) / punctuation (0 or 1) / space
        if match == nil then
            match = line.text:match("^[^{%s]*%s".. balise) -- beginning / punctuation (0 or 1) / letters (1 or more) / punctuation (0 or 1) / letters (0 or more) / punctuation (0 or 1) / space
            if match == nil then
                match = line.text:match("%s[^{%s]*".. balise)
                if match == nil then
                    match = line.text:match("^[^{%s]*".. balise)
                    if match == nil then
                        match = line.text:match("%s[^{%s]*$")
                        if match == nil then
                            match = line.text:match("^[^{%s]*$")
                            if (beforetext ~= nil and string.starts(match:sub(1),beforetext)) then
                                texttoadd = texttoadd .. "{\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(beforetext:len()+1)
                            else
                                texttoadd = texttoadd .. "{\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(1)
                            end
                            beforetext = nil
                            line.text = texttoadd
                            if (start_time ~= nill) then
                                line.start_time = start_time
                            end
                            subs[i] = line
                            texttoadd = ""
                        else
                            if (beforetext ~= nil and string.starts(match:sub(2),beforetext)) then
                                texttoadd = texttoadd .. "{\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(beforetext:len()+2)
                            else
                                texttoadd = texttoadd .. " {\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(2)
                            end
                            beforetext = nil
                            line.text = texttoadd
                            if (start_time ~= nill) then
                                line.start_time = start_time
                            end
                            subs[i] = line
                            texttoadd = ""
                        end
                    else
                        if (beforetext ~= nil and string.starts(match:sub(1, -(balise:len()+1)),beforetext)) then
                            texttoadd = texttoadd .. "{\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(beforetext:len()+1, -(balise:len()+1))
                            beforetext = match:sub(1, -(balise:len()+1))
                        else
                            start_time = line.start_time
                            texttoadd = "{\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(1, -(balise:len()+1))
                            beforetext = match:sub(1, -(balise:len()+1))
                        end
                        table.insert(todelete, i)
                    end
                else
                    if (beforetext ~= nil and string.starts(match:sub(2, -(balise:len()+1)),beforetext)) then
                        texttoadd = texttoadd .. "{\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(beforetext:len()+2, -(balise:len()+1))
                        beforetext = match:sub(2, -(balise:len()+1))
                    else
                        texttoadd = texttoadd .. " {\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(2, -(balise:len()+1))
                        beforetext = match:sub(2, -(balise:len()+1))
                    end
                    table.insert(todelete, i)
                end
            else
                if (beforetext ~= nil and string.starts(match:sub(1, -(balise:len()+2)),beforetext)) then
                    texttoadd = texttoadd .. "{\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(beforetext:len()+1, -(balise:len()+2))
                    beforetext = match:sub(1, -(balise:len()+2))
                else
                    start_time = line.start_time
                    texttoadd = "{\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(1, -(balise:len()+2))
                    beforetext = match:sub(1, -(balise:len()+2))
                end
                table.insert(todelete, i)
            end
        else
            if (beforetext ~= nil and string.starts(match:sub(2, -(balise:len()+2)),beforetext)) then
                texttoadd = texttoadd .. "{\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(beforetext:len()+2, -(balise:len()+2))
                beforetext = match:sub(2, -(balise:len()+2))
            else
                texttoadd = texttoadd .. " {\\k" .. (line.end_time-line.start_time)/10 .. "}" .. match:sub(2, -(balise:len()+2))
                beforetext = match:sub(2, -(balise:len()+2))
            end
            table.insert(todelete, i)
        end
    end
    subs.delete(todelete)

    aegisub.set_undo_point(script_name)
end

aegisub.register_macro(script_name, script_description, convert_line)
