local null_ls = require 'null-ls'
local helpers = require 'null-ls.helpers'

local betty_style = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { 'c', 'cpp' },
  generator = null_ls.generator {
    command = 'betty-style',
    args = { '$FILENAME' },
    from_stderr = false,
    format = 'line',
    check_exit_code = function(code, _)
      return code <= 1
    end,
    on_output = helpers.diagnostics.from_pattern(
      '[^:]+:(%d+): (%w+): (.*)$',
      { 'row', 'severity', 'message' },
      {
        severities = {
          WARNING = helpers.diagnostics.severities.warning,
          ERROR = helpers.diagnostics.severities.error,
        },
      }
    ),
  },
}

local betty_doc = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { 'c', 'cpp' },
  generator = null_ls.generator {
    command = 'betty-doc',
    args = { '$FILENAME' },
    from_stderr = true,
    format = 'line',
    check_exit_code = function(code, _)
      return code <= 1
    end,
    on_output = helpers.diagnostics.from_pattern(
      '[^:]+:(%d+): (%w+): (.*)$',
      { 'row', 'severity', 'message' }
    ),
  },
}

null_ls.setup {
  sources = {
    -- null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.code_actions.eslint_d,
    -- null_ls.builtins.formatting.eslint_d,
    betty_style,
    betty_doc,
  },
}
