local M = {}

local hl_groups = {
    { group = "MatchingAA", color = "#FF6188" },
    -- { group = "MatchingAB", color = "#A9DC76" },
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

local get_visual_range = function()
    local start_row, start_col = vim.fn.line("v"), vim.fn.col("v")
    local end_row, end_col = vim.fn.line("."), vim.fn.col(".")

    if vim.fn.mode() == "V" then
        start_col, end_col = 1, vim.fn.col("$") - 1
    end

    if start_row > end_row then
        start_row, end_row = end_row, start_row
    end

    if start_row == end_row and start_col > end_col then
        start_col, end_col = end_col, start_col
    end

    return start_row, start_col, end_row, end_col
end

local match_id_map = {}
local add_match = function(pattern)
    local id = vim.fn.matchadd(next_group(), pattern)
    if match_id_map[pattern] then vim.fn.matchdelete(match_id_map[pattern]) end
    match_id_map[pattern] = id
end

function _G.match_add_normal()
    local pattern = vim.fn.expand("<cword>")
    add_match(pattern)
end

local function match_add_visual()
    local start_row, start_col, end_row, end_col = get_visual_range()
    local lines =
        vim.api.nvim_buf_get_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, {})
    local pattern = table.concat(lines, "\n")
    add_match(pattern)
end

function _G.match_delete()
    local matched = false
    local _, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
    local current_line = vim.api.nvim_get_current_line()
    for pattern, id in pairs(match_id_map) do
        local start_pos, end_pos = string.find(current_line, pattern)
        if start_pos and end_pos and cursor_col >= start_pos - 1 and cursor_col <= end_pos - 1 then
            vim.fn.matchdelete(id)
            matched = true
            match_id_map[pattern] = nil
            break
        end
    end
    if not matched then vim.cmd("norm! D") end
end

local function find_all_matches(str, pattern)
    local matches = {}
    local start_pos = 1
    while true do
        local start, finish = string.find(str, pattern, start_pos)
        if start then
            table.insert(matches, { start, finish })
            start_pos = finish + 1
        else
            break
        end
    end
    return matches
end

local function jump_to_previous_match()
    local cursor_line, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
    local lines = vim.api.nvim_buf_get_lines(0, 0, cursor_line, false)

    for i = #lines, 1, -1 do
        local line = lines[i]
        local candidates = {}

        for pattern in pairs(match_id_map) do
            local matches = find_all_matches(line, pattern)

            for j = #matches, 1, -1 do
                local start, finish = unpack(matches[j])
                table.insert(candidates, { start, finish })
            end
        end

        for _, c in ipairs(candidates) do
            local start = c[1]

            if i == cursor_line and start < cursor_col - 1 then
                vim.api.nvim_win_set_cursor(0, { i, start - 1 })
                return
            elseif i ~= cursor_line then
                vim.api.nvim_win_set_cursor(0, { i, start - 1 })
                return
            end
        end
    end
end

local function jump_to_next_match()
    local cursor_line, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
    local lines = vim.api.nvim_buf_get_lines(0, cursor_line - 1, -1, false)

    for i, line in ipairs(lines) do
        local candidates = {}
        local current_linenr = cursor_line + i - 1

        for pattern in pairs(match_id_map) do
            local matches = find_all_matches(line, pattern)

            for _, match in ipairs(matches) do
                local start, finish = unpack(match)
                table.insert(candidates, { start, finish })
            end
        end

        for _, c in ipairs(candidates) do
            local start = c[1]

            if current_linenr == cursor_line and start > cursor_col + 1 then
                vim.api.nvim_win_set_cursor(0, { current_linenr, start - 1 })
                return
            elseif current_linenr ~= cursor_line then
                vim.api.nvim_win_set_cursor(0, { current_linenr, start - 1 })
                return
            end
        end
    end
end

vim.keymap.set("n", "<C-k>", function() jump_to_previous_match() end, {})
vim.keymap.set("n", "<C-j>", function() jump_to_next_match() end, {})

vim.keymap.set("n", "D", function()
    vim.opt.opfunc = "v:lua.match_delete"
    return "g@<cr>"
end, { expr = true })

vim.keymap.set("n", "M", function()
    vim.opt.opfunc = "v:lua.match_add_normal"
    return "g@<cr>"
end, { expr = true })

vim.keymap.set("x", "M", function()
    match_add_visual()
    vim.api.nvim_input("<Esc>")
end, {})

return M
