local util = require("data-util");

local hcl_name = mods.Krastorio2 and "kr-hydrogen-chloride" or hcl_name

data:extend({
  {
    type = "item",
    name = "pcb-substrate",
    icon = "__bzchlorine__/graphics/icons/pcb-substrate.png",
    icon_size = 128,
    subgroup = "intermediate-product",
    order = "f[advanced-circuit][pcb-substrate]",
    stack_size = 200,
  },
})
if not (mods.bobelectronics or mods.MDbobelectronics or mods.MDbobelectronics2) then
data:extend({
  {
    type = "item",
    name = "pcb",
    icon = "__bzchlorine__/graphics/icons/pcb.png",
    icon_size = 128,
    subgroup = "intermediate-product",
    order = "f[advanced-circuit][pcb]",
    stack_size = 200,
  },

})
end

data:extend({
  {
    type = "recipe",
    name = "pcb-substrate",
    results = {
      {type="item", name="pcb-substrate", amount=12},
    },
    ingredients = {
      {type="fluid", name="epoxy", amount=30},
      {type="item", name="plastic-bar", amount=3},
    },
    enabled = false,
    category = "chemistry",
    energy_required = 6,
  },
})
util.add_unlock("advanced-circuit", "pcb-substrate")
-- These updates should be in data phase
util.replace_some_ingredient("pcb-substrate", "plastic-bar", 1, "silica", 3, {force=true})

if not (mods.bobelectronics or mods.MDbobelectronics or mods.MDbobelectronics2) then
data:extend({
  {
    type = "recipe",
    name = "pcb",
    results = {
      {type="item", name="pcb", amount=4},
    },
    ingredients = util.me.more() and {
      {type="item", name="pcb-substrate", amount=4},
      {type="item", name="copper-plate", amount=1},
      {type="item", name="ferric-chloride", amount=2},
      {type="fluid", name="water", amount=20},
    } or {
      {type="item", name="pcb-substrate", amount=4},
      {type="item", name="copper-plate", amount=1},
      {type="fluid", name=hcl_name, amount=30}
    },
    enabled = false,
    category = "crafting-with-fluid",
    energy_required = 8,
  },
})
util.add_unlock("advanced-circuit", "pcb")

end
