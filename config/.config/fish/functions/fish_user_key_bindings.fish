# rewrite keybinds
function fish_user_key_bindings
  
  #fzf
  bind \cf fzf_change_directory

	# vim-like completion
	bind \cl forward-char
end

fzf_configure_bindings --directory=\co
