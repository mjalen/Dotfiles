;;          __
;;         ( o`-
;;         /  \
;;         |  |
;;          ^^ BP
;;
;; Fennel Config for NVIM
;;    by Jalen Moore
;;
;; Why Fennel? Well... why not!
;;

; TODO Move long enough config portions to their own files.
; TODO Make lualine look a little nicer. Angles are gross :)
; TODO General organization.
; TODO Backup to Github.
; TODO Find proper language completion for JS, TS, Vue. Eslint currents tells only errors.

;; General Settings.
(let [o vim.o]
  (set o.cursorline true)
  (set o.tabstop 4)
  (set o.shiftwidth 4)
  (set o.softtabstop 4)
  (set o.autoindent true)
  (set o.number true)
  (set o.wrap true)
  (set o.scrolloff 3)
  (set o.wildmenu true)
  (set o.wrap true)
  (set o.autoread true)
  (set o.dir "~/tmp")
  (set o.hidden true)
  (set o.cc 125)
  )

;; Packer Plugins.
(let [packer (require :packer)]
  (packer.startup 
    (fn [use]
      ; Necessary Redundancy
      (use "wbthomason/packer.nvim")
      (use "rktjmp/hotpot.nvim")
                    
      ; LSP + nvim-cmp
      (use "neovim/nvim-lspconfig")
      (use "hrsh7th/cmp-nvim-lsp")
      (use "hrsh7th/cmp-buffer")
      (use "hrsh7th/nvim-cmp")
      (use "PaterJason/cmp-conjure")

      ; Snippet Engine (not enabled) 
      (use "L3MON4D3/LuaSnip")
      (use "saadparwaiz1/cmp_luasnip")

      ; Telescope
      (use "nvim-lua/plenary.nvim")
      (use "nvim-telescope/telescope.nvim")
      (use "nvim-telescope/telescope-file-browser.nvim")

      ; Terminal
      (use "akinsho/toggleterm.nvim")

      ; Aesthetics
      (use "b0o/incline.nvim")
      (use "nvim-lualine/lualine.nvim")
      (use "nyoom-engineering/oxocarbon.nvim")
      (use "nvim-treesitter/nvim-treesitter")
                  
      ; Git
      (use "lewis6991/gitsigns.nvim")
                    
      ; Lisp (fnl, cl)
      (use "Olical/aniseed")
      (use "Olical/conjure")
      )))

;; Git
(let [gitsigns (require :gitsigns)]
  (gitsigns.setup {}))

;; LSP
(let [lsp (require :lspconfig)]
  (lsp.eslint.setup {})
  (lsp.fennel-ls.setup {})) 

; CMP
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

;; Telescope
(let [telescope (require :telescope)]
  (let [actions (require "telescope.actions")]
    (telescope.setup 
      {:defaults 
       {:mappings 
        {:i 
         {"<esc>" actions.close}}}}))
  (telescope.load_extension "file_browser"))

;; Aesthetics
; lualine
(let [lualine (require :lualine)]
  (lualine.setup 
    {:options
     {"icons_enabled" 1
      "theme" :auto}
     :sections 
     {"lualine_a" [:mode]
      "lualine_b" [:branch :diff]
      "lualine_c" [:filename]
      "lualine_x" [:filetype]
      "lualine_y" [:progress]
      "lualine_z" [:location]}}))

; incline (file name at top right)
(let [incline (require :incline)]
  (incline.setup {}))

; oxocarbon theme
(set vim.opt.background :dark)
(vim.cmd "colorscheme oxocarbon")

; Toggle Term
(let [toggleterm (require :toggleterm)]
  (toggleterm.setup {}))

; Tree-sitter
(let [treesitter (require "nvim-treesitter.configs")]
  (treesitter.setup 
    {"ensure_installed" [:c :cpp :vue :javascript :html :css :vim :lua :fennel]
     "highlight" {:enable 1}}))


;; Keybindings
(let [map vim.api.nvim_set_keymap]
  ; Telescope
  (map "n" ",f" "<cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>" {})
  (map "n" ",d" "<cmd>lua require('telescope.builtin').find_files()<cr>" {})
  (map "n" ",g" "<cmd>lua require('telescope.builtin').live_grep()<cr>" {})
  (map "n" ",b" "<cmd>lua require('telescope.builtin').buffers()<cr>" {})
  (map "n" "/" "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>" {})

  ; Toggle Term
  (map "n" ",m" "<Cmd>exe v:count1 . 'ToggleTerm'<CR>" {})
  (map "i" ",m" "<Esc><Cmd>exe v:count1 . 'ToggleTerm'<CR>" {})
  (map "t" ",m" "<Cmd>exe v:count1 . 'ToggleTerm'<CR>" {})
  )

