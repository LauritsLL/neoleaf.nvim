-- Statusline: connection, collaborators, compile status.
local M = {}
local S = { connected = false, users = {}, compile = nil } -- compile: 'ok'|'error'|'running'|nil

for name, def in pairs({
  OverleafOn = { fg = '#a6e3a1', bold = true }, OverleafOff = { fg = '#f38ba8', bold = true },
  OverleafUsers = { fg = '#89b4fa' }, OverleafWarn = { fg = '#f9e2af', bold = true },
}) do vim.api.nvim_set_hl(0, name, vim.tbl_extend('keep', { default = true }, def)) end

--- Call from event handlers: M.set{connected=true}, M.set{users={'Anna','Bo'}}, M.set{compile='error'}
function M.set(t)
  for k, v in pairs(t) do S[k] = v end
  vim.cmd('redrawstatus')
end

--- lualine: { require('overleaf.statusline').status }   (or put in 'statusline' as %{%v:lua...%})
function M.status()
  if not S.connected then return '%#OverleafOff#󰖪 offline%*' end
  local out = { '%#OverleafOn#󰖩 online%*' }
  if #S.users > 0 then out[#out + 1] = ('%%#OverleafUsers# %d (%s)%%*'):format(#S.users, table.concat(S.users, ', ')) end
  local c = S.compile
  if c == 'ok' then out[#out + 1] = '%#OverleafOn#✔%*'
  elseif c == 'error' then out[#out + 1] = '%#OverleafOff#✘%*'
  elseif c == 'running' then out[#out + 1] = '%#OverleafWarn#⟳%*' end
  return table.concat(out, ' ')
end

return M
