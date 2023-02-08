;; Language Config
; Includes LSP config and language related config.

; TODO Implement clangd lang server (C/C++)
; TODO Find proper language completion for JS, TS, Vue. Eslint currents tells only errors.

;; LSP
(let [lsp (require :lspconfig)]
  (lsp.eslint.setup {})
  (lsp.fennel-ls.setup {})) 

;; CMP (Completion)
(let [cmp (require :cmp)]
  (cmp.setup 
    {:snippet 
     {:expand 
      (fn [args]
        (let [luasnip (require :luasnip)] 
          (luasnip.lsp_expand args.body)))} 
     :window 
     {:completion (cmp.config.window.bordered)
      :documentation (cmp.config.window.bordered)}
     :mapping 
     (cmp.mapping.preset.insert 
       {"<C-b>" (cmp.mapping.scroll_docs -4)
        "<C-f>" (cmp.mapping.scroll_docs 4)
        "<C-e>" (cmp.mapping.abort)
        "<CR>" (cmp.mapping.confirm {:select true})})

     :sources
     (cmp.config.sources [{:name "nvim_lsp"}
                          {:name :conjure}
                          {:name :luasnip}]
                         [{:name :buffer}])})) 




