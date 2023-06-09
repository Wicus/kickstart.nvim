return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'f3fora/cmp-spell',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local cmp_kinds = {
      Text = '  ',
      Method = '  ',
      Function = '  ',
      Constructor = '  ',
      Field = '  ',
      Variable = '  ',
      Class = '  ',
      Interface = '  ',
      Module = '  ',
      Property = '  ',
      Unit = '  ',
      Value = '  ',
      Enum = '  ',
      Keyword = '  ',
      Snippet = '  ',
      Color = '  ',
      File = '  ',
      Reference = '  ',
      Folder = '  ',
      EnumMember = '  ',
      Constant = '  ',
      Struct = '  ',
      Event = '  ',
      Operator = '  ',
      TypeParameter = '  ',
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered {
          border = 'single',
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel',
        },
        documentation = cmp.config.window.bordered {
          border = 'single',
          winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel',
        },
      },
      formatting = {
        format = function(_, vim_item)
          vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
          local label = vim_item.abbr
          local truncated_label = vim.fn.strcharpart(label, 0, 50)
          if truncated_label ~= vim_item.abbr then
            vim_item.abbr = truncated_label .. '...'
          end
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-l>'] = cmp.mapping.complete {},
        ['<C-y>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<C-n>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'spell' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp_signature_help' },
      },
    }
  end,
}
