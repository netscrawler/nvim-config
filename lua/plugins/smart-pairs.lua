return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({
                check_ts = true,
                ts_config = {
                    lua = { 'string' },
                    go = { 'string' },
                    javascript = { 'template_string' },
                },
            })

            -- Setup cmp integration
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
    }
}

