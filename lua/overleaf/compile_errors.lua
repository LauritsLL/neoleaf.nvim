-- Parse latexmk log into quickfix entries.
local M = {}

-- Compile errors ------------------------------------------------------------
--- Parse log text -> list of {filename, lnum, text}. Needs -file-line-error for file:line.
function M.parse_log(log, root)
  local errs, cur = {}, nil
  for line in (log .. '\n'):gmatch('(.-)\r?\n') do
    local f, l, msg = line:match('^(%.?/?[^%s:]+%.%a+):(%d+): (.*)')
    if f then
      cur = { filename = (root and (root .. '/' .. f:gsub('^%./', '')) or f), lnum = tonumber(l), text = msg }
      errs[#errs + 1] = cur
    elseif line:match('^! ') then
      cur = { filename = '', lnum = 1, text = line:sub(3) }
      errs[#errs + 1] = cur
    elseif cur and cur.filename == '' then
      local l2 = line:match('^l%.(%d+)')
      if l2 then cur.lnum = tonumber(l2); cur = nil end
    end
    local bib = line:match('I couldn\'t open database file (%S+)') or line:match('No file (%S+%.bib)')
    if bib then errs[#errs + 1] = { filename = '', lnum = 1, text = 'Missing .bib: ' .. bib } end
  end
  return errs
end

--- :Overleaf errors  -> fills quickfix, jumps to first
function M.show(logpath, root)
  local fh = io.open(logpath, 'r'); if not fh then return vim.notify('no log: ' .. logpath, vim.log.levels.WARN) end
  local errs = M.parse_log(fh:read('*a'), root); fh:close()
  if #errs == 0 then return vim.notify('No errors in log') end
  vim.fn.setqflist(errs, 'r'); vim.cmd('copen | cfirst')
end

return M
