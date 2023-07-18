local neogen_config = require('neogen')

neogen_config.setup {
  enabled = true,
  snippet_engine = 'luasnip',
  languages = {
    python = {
      template = {
        annotation_convention = "reST"
      }
    },
  }
}
