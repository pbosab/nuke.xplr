local open_custom_commands = {}

local nuke_mode = {
	name = "nuke",
	key_bindings = {
		on_key = {
			["o"] = {
				help = "open",
				messages = {
					{ CallLuaSilently = "custom.nuke_open" },
					"PopMode",
				},
			},
		},
	},
}

local function exec_custom(command, node)
	command = command:gsub("{}", '"' .. node.absolute_path .. '" &')
	return { { BashExecSilently = command } }
end

local function open(ctx)
	local node = ctx.focused_node
	local node_mime = node.mime_essence

	if node.is_dir or (node.is_symlink and node.symlink.is_dir) then
		return { "Enter" }
	else
		-- prevent empty mime
		if node_mime == "" then
			local node_mime_empty_handle = io.popen("file --mime-type -b " .. node.absolute_path)
			local node_mime_empty_result = node_mime_empty_handle:read("*a")
			node_mime_empty_handle:close()
			node_mime = node_mime_empty_result
		end
		for _, entry in ipairs(open_custom_commands) do
			local command = entry["command"]
			if command ~= nil then
				if
					node_mime == entry["mime"] or (entry["mime_regex"] ~= nil and node_mime:match(entry["mime_regex"]))
				then
					return exec_custom(command, node)
				end
			end
		end
	end
end

local function setup(args)
	xplr.config.modes.custom.nuke = nuke_mode
	xplr.fn.custom.nuke_open = open
	if args == nil then
		args = {}
	end
	if args.open then
		if args.open.custom then
			open_custom_commands = args.open.custom
		end
	end
end

return { setup = setup }
