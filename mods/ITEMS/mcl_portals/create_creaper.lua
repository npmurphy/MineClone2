local S = minetest.get_translator("mcl_portals")


local function available_for_summoning(p)
	minetest.log("action", "checking " .. minetest.pos_to_string(p) .. "!")
	local nn = minetest.get_node(p).name
	minetest.log("action", "its name is" .. tostring(nn)  .. "!")
	local diamond = nn == "mcl_core:diamondblock"
	minetest.log("action", "it is diamond" .. tostring(diamond ) .. "!")
	-- if nn ~= "air" and minetest.get_item_group(nn, "fire") ~= 1 then
	-- 	return false, diamond
	-- end
	return diamond -- true
end



--[[ ITEM OVERRIDES ]]

-- local longdesc = minetest.registered["mobs_mc:head_creeper"]._doc_items_longdesc
-- longdesc = longdesc .. "\n" .. S("overload:head_creeper ")
-- local usagehelp = S("To open a Nether portal, place an upright frame of obsidian with a width of at least 4 blocks and a height of 5 blocks, leaving only air in the center. After placing this frame, light a fire in the obsidian frame. Nether portals only work in the Overworld and the Nether.")
--"mcl_heads:creeper" "mobs_mc:head_creeper",
---minetest.override_item("mcl_heads:creeper", {
minetest.override_item("mcl_core:emeraldblock", {
	_doc_items_longdesc = "something", -- longdesc,
	_doc_items_usagehelp = "herell", -- usagehelp,
	--on_destruct = destroy_nether_portal,
	_on_ignite = function(user, pointed_thing)

		local x, y, z = pointed_thing.under.x, pointed_thing.under.y, pointed_thing.under.z
		minetest.log("action", "Checking if its a mob!!" .. minetest.pos_to_string({x=x,y=y,z=z})..".")
		local check_body_shape = (
			available_for_summoning({x = x, y=y-1, z=z}) and 
			available_for_summoning({x = x, y= y-2, z=z}) and 
			available_for_summoning({x = x-1, y=y-1, z=z}) and 
			available_for_summoning({x = x+1, y=y-1, z=z})) or
			(
			available_for_summoning({x = x, y= y-1, z=z}) and 
			available_for_summoning({x = x, y= y-2, z=z}) and 
			available_for_summoning({x = x, y=y-1, z=z-1}) and 
			available_for_summoning({x = x, y=y-1, z=z+1}))

		if check_body_shape then
			minetest.log("action", "MAKING A MOB!!!" .. minetest.pos_to_string({x=x,y=y,z=z})..".")
			new_mob = minetest.add_entity({x=x, y=y, z=z}, "mobs_mc:creeper")
			return true
		else
			return false
		end
	end,
})

