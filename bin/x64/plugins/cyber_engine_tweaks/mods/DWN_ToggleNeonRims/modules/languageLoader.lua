languageLoader = {}

function languageLoader.GetLanguageFile()
    local gameLang = Game.NameToString(Game.GetSettingsSystem():GetVar("/language", "OnScreen"):GetValue())
    local languageFile = io.open("languages/"..gameLang..".json", "r")
    local languageContent = json.decode(languageFile:read("*a"))
    languageFile:close()
    return languageContent
end

return languageLoader