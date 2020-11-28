local match = require 'completion.matching'

local M = {}


---[ INTERNAL STATE ]----------------------------------------------------------
local ready = false  -- Set to true when completion items are available
local items = {}     -- Stashed completion items so far

-- Helper function, filter a given list based on a predicate
local function filter(items, pred)
	local result = {}
	for _, item in ipairs(items) do
		if pred(item) then
			result[#result + 1] = item
		end
	end
	return result
end

-- Helper function, maps each item onto another item of a new list
local function map(items, fun)
	local result = {}
	for _,item in ipairs(items) do
		result[#result + 1] = fun(item)
	end
	return result
end


---[ AUXILIARRY PUBLIC INTERFACE ]---------------------------------------------
-- These functions are exposed to the outside for our Vim script bridge to
-- Vlime. They are not meant to be used in any other context.

function M._onSimpleComplete(result)
	result = result or {}
	items = map(result, function (item)
		return {word = item, icase = true}
	end)
	ready = true
end

function M._onFuzzyComplete(result)
	result = result or {}
	items = map(result, function (item)
		return {word = item[1], menu = item[4], icase = true}
	end)
	ready = true
end

---[ OUTSIDE CONTACT SURFACE ]-------------------------------------------------
-- These functions and variables are exposed as properties of the source

-- Entry point into completion. This function will be called by completion-nvim
-- when completion items are requested.
local function on_trigger(_, opt)
	vim.call('completion#vlime#on_trigger', opt.prefix)
end

-- Will be called when completion-nvim notices that the source is ready and
-- wants to request the results.
local function on_completed(prefix, score)
	-- Accumulate ompletion items suitable for processing by completion-nvim
	local matched_items = {}
	for _, item in ipairs(items) do
		match.matching(matched_items, prefix, item)
	end

	ready = false
	return matched_items
end

-- The source table which can be registered with completion-nvim
M.source = {
	trigger = on_trigger,
	item = on_completed,
	callback = function() return ready end,
}

return M


-- vim: tw=79 ts=4 noet
