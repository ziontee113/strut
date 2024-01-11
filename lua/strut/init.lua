local M = {}

local hl_groups = {
    { group = "MatchingAA", color = "#FF6188" },
    { group = "MatchingAB", color = "#A9DC76" },
    { group = "MatchingAC", color = "#78DCE8" },
    { group = "MatchingAD", color = "#FFD866" },
    { group = "MatchingAE", color = "#FC9867" },
    { group = "MatchingAF", color = "#AB9DF2" },
    { group = "MatchingAG", color = "darkred" },
    { group = "MatchingAH", color = "#FD6883" },
    { group = "MatchingAI", color = "#1981F0" },
    { group = "MatchingAJ", color = "#6EABEC" },
    { group = "MatchingAK", color = "#9261E2" },
    { group = "MatchingAL", color = "#E261AB" },
    { group = "MatchingAM", color = "#B7FC4F" },
    { group = "MatchingAN", color = "#4FD9FC" },
    { group = "MatchingAO", color = "#F9D9B7" },
    { group = "MatchingAP", color = "#F9B7F9" },
    { group = "MatchingAQ", color = "#006400" },
    { group = "MatchingAR", color = "#008000" },
    { group = "MatchingAS", color = "#008080" },
    { group = "MatchingAT", color = "#008B8B" },
    { group = "MatchingAU", color = "#00BFFF" },
    { group = "MatchingAV", color = "#00CED1" },
    { group = "MatchingAW", color = "#00FA9A" },
    { group = "MatchingAX", color = "#00FF00" },
    { group = "MatchingAY", color = "#00FF7F" },
    { group = "MatchingAZ", color = "#00FFFF" },
    { group = "MatchingBA", color = "#1E90FF" },
    { group = "MatchingBB", color = "#20B2AA" },
    { group = "MatchingBC", color = "#228B22" },
    { group = "MatchingBD", color = "#2E8B57" },
    { group = "MatchingBE", color = "#2F4F4F" },
    { group = "MatchingBF", color = "#32CD32" },
    { group = "MatchingBG", color = "#3CB371" },
    { group = "MatchingBH", color = "#40E0D0" },
    { group = "MatchingBI", color = "#4169E1" },
    { group = "MatchingBJ", color = "#4682B4" },
    { group = "MatchingBK", color = "#483D8B" },
    { group = "MatchingBL", color = "#48D1CC" },
    { group = "MatchingBM", color = "#4B0082" },
    { group = "MatchingBN", color = "#556B2F" },
    { group = "MatchingBO", color = "#5F9EA0" },
    { group = "MatchingBP", color = "#6495ED" },
    { group = "MatchingBQ", color = "#66CDAA" },
    { group = "MatchingBR", color = "#696969" },
    { group = "MatchingBS", color = "#6A5ACD" },
    { group = "MatchingBT", color = "#6B8E23" },
    { group = "MatchingBU", color = "#708090" },
    { group = "MatchingBV", color = "#778899" },
    { group = "MatchingBW", color = "#7B68EE" },
    { group = "MatchingBX", color = "#87CEFA" },
    { group = "MatchingBY", color = "#87CEEB" },
    { group = "MatchingBZ", color = "#00BFFF" },
    { group = "MatchingCA", color = "#2F4F4F" },
    { group = "MatchingCB", color = "#48D1CC" },
    { group = "MatchingCC", color = "#20B2AA" },
    { group = "MatchingCD", color = "#5F9EA0" },
    { group = "MatchingCE", color = "#008B8B" },
    { group = "MatchingCF", color = "#008080" },
    { group = "MatchingCG", color = "#7FFFD4" },
    { group = "MatchingCH", color = "#90EE90" },
    { group = "MatchingCI", color = "#98FB98" },
    { group = "MatchingCJ", color = "#8FBC8F" },
    { group = "MatchingCK", color = "#7CFC00" },
    { group = "MatchingCL", color = "#7FFF00" },
    { group = "MatchingCM", color = "#ADFF2F" },
    { group = "MatchingCN", color = "#00FF7F" },
    { group = "MatchingCO", color = "#00FA9A" },
    { group = "MatchingCP", color = "#32CD32" },
    { group = "MatchingCQ", color = "#9ACD32" },
    { group = "MatchingCR", color = "#808000" },
    { group = "MatchingCS", color = "#556B2F" },
    { group = "MatchingCT", color = "#7FFF00" },
    { group = "MatchingCU", color = "#ADFF2F" },
    { group = "MatchingCV", color = "#00FF7F" },
    { group = "MatchingCW", color = "#00FA9A" },
    { group = "MatchingCX", color = "#32CD32" },
    { group = "MatchingCY", color = "#9ACD32" },
    { group = "MatchingCZ", color = "#808000" },
    { group = "MatchingDA", color = "#556B2F" },
    { group = "MatchingDB", color = "#7FFF00" },
    { group = "MatchingDC", color = "#ADFF2F" },
    { group = "MatchingDD", color = "#00FF7F" },
    { group = "MatchingDE", color = "#00FA9A" },
    { group = "MatchingDF", color = "#32CD32" },
    { group = "MatchingDG", color = "#9ACD32" },
    { group = "MatchingDH", color = "#808000" },
    { group = "MatchingDI", color = "#556B2F" },
    { group = "MatchingDJ", color = "#7FFF00" },
}

for _, mapping in pairs(hl_groups) do
    vim.api.nvim_set_hl(0, mapping["group"], {
        fg = "#232627",
        bg = mapping["color"],
        bold = true,
    })
end

local last_group = 0
local function next_group()
    last_group = last_group + 1
    if last_group > #hl_groups then last_group = 1 end
    return hl_groups[last_group]["group"]
end

function _G.match_add()
    local pattern = vim.fn.expand("<cword>")
    vim.fn.matchadd(next_group(), pattern)
end

vim.keymap.set("n", "M", function()
    vim.opt.opfunc = "v:lua.match_add"
    return "g@<cr>"
end, { expr = true })

return M
