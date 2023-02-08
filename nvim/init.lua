-- Simple lua init. Most things are done in fnl

-- TODO Find a way to not have to use packer and hotpot twice
require('packer').startup(function(use)
	use "wbthomason/packer.nvim"
	use "rktjmp/hotpot.nvim"
end)

-- Load FNL
require("hotpot")
require("core")
