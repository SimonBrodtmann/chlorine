local util = require("data-util");

local cl_name = mods.Krastorio2 and "kr-chlorine" or "chlorine"
local hcl_name = mods.Krastorio2 and "kr-hydrogen-chloride" or "hydrogen-chloride"


if not mods.Krastorio2 then
data:extend({
  {
    type = "fluid",
    name = cl_name,
    default_temperature = 25,
    heat_capacity = "0.1kJ",
    base_color = {r=0.60, g=0.90, b=0.50},
    flow_color = {r=0.60, g=1.00, b=0.50},
    icon = "__bzchlorine__/graphics/icons/chlorine.png",
    icon_size = 128,
    order = "a[fluid]-f[chlorine]",
  },
  {
    type = "fluid",
    name = hcl_name,
    default_temperature = 25,
    heat_capacity = "0.1kJ",
    base_color = {r=0.80, g=0.90, b=0.70},
    flow_color = {r=0.80, g=1.00, b=0.70},
    icon = "__bzchlorine__/graphics/icons/hcl.png",
    icon_size = 128,
    order = "a[fluid]-f[chlorine-h]",
  },
})
end

if util.me.more() then
data:extend({
  {
    type = "item",
    name = "ferric-chloride",
    icon = "__bzchlorine__/graphics/icons/ferric-chloride.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "raw-material",
    order = "b[chlorine-fe]",
    stack_size = 100,
  },
  {
    type = "fluid",
    name = "vinyl-chloride",
    default_temperature = 25,
    heat_capacity = "0.1kJ",
    base_color = {r=0.90, g=0.90, b=0.75},
    flow_color = {r=0.90, g=1.00, b=0.75},
    icon = "__bzchlorine__/graphics/icons/vinyl-chloride.png",
    icon_size = 128,
    order = "a[fluid]-f[chlorine-v]",
  },
})
end

if not mods.Krastorio2 then
data:extend({
  {
    type = "recipe",
    name = cl_name,
    results = {{type="fluid", name=cl_name, amount=10}},
    ingredients = {{type="item", name="salt", amount=2}},
    enabled = false,
    category = "chemistry",
    subgroup = "fluid-recipes",
    energy_required = 0.5,
  },
  {
    type = "recipe",
    name = "hydrogen-chloride-pure",
    results = {{type="fluid", name=hcl_name, amount=20}},
    ingredients = {
      {type="fluid", name="water", amount=10},
      {type="fluid", name=cl_name, amount=10},
    },
    enabled = false,
    category = "chemistry",
    subgroup = "fluid-recipes",
    energy_required = 10,
  },
})
else
  util.replace_ingredient("kr-water-electrolysis", "kr-sand", "salt", 2)
  if util.se6() then
    util.multiply_time("kr-water-electrolysis", 5.0/28)
  else
    util.multiply_time("kr-water-electrolysis", 0.5)
  end
end
data:extend({
  {
    type = "recipe",
    name = "hydrogen-chloride-salt",
    results = {{type="fluid", name=hcl_name, amount=10}},
    ingredients = {
      {type="item", name="salt", amount=1},
      {type="fluid", name="water", amount=5},
      {type="fluid", name="sulfuric-acid", amount=5},
    },
    enabled = false,
    category = "chemistry",
    subgroup = "fluid-recipes",
    energy_required = 1,
  },
})

if util.me.more() then
data:extend({
  {
    type = "recipe",
    name = "ferric-chloride",
    results = {{type="item", name="ferric-chloride", amount=2}},
    ingredients = {
      {type="item", name="iron-plate", amount=2},
      {type="fluid", name=cl_name, amount=30},
    },
    enabled = false,
    category = "chemistry",
    energy_required = 3,
  },
  {
    type = "recipe",
    name = "ferric-chloride-hcl",
    results = {{type="item", name="ferric-chloride", amount=4}},
    icons = {
        {icon = "__bzchlorine__/graphics/icons/ferric-chloride.png", icon_size=64, scale=1},
        {icon = "__bzchlorine__/graphics/icons/hcl.png", icon_size=128, scale=0.25, shift={8,-8}},
    },
    ingredients = {
      {type="item", name="iron-ore", amount=1},
      {type="fluid", name=hcl_name, amount=120},
    },
    enabled = false,
    category = "chemistry",
    energy_required = 3,
  },
  {
    type = "recipe",
    name = "vinyl-chloride",
    results = {{type="fluid", name="vinyl-chloride", amount=20}},
    ingredients = {
      {type="fluid", name=cl_name, amount=10},
      {type="fluid", name="petroleum-gas", amount=20},
    },
    enabled = false,
    category = "chemistry",
    subgroup = "fluid-recipes",
    energy_required = 3,
  },
})
end
util.add_unlock("plastics", "vinyl-chloride")

if not mods.Krastorio2 then
data:extend({
  {
    type="technology",
    name="chlorine-processing",
    icons = {
      {icon = "__bzchlorine__/graphics/technology/salt-tech.png", icon_size = 256, tint={a=.75,r=1,b=1,g=1} },
    },
    effects = {
      { type = "unlock-recipe", recipe = cl_name },
      { type = "unlock-recipe", recipe = "hydrogen-chloride-salt" },
      { type = "unlock-recipe", recipe = "hydrogen-chloride-pure" },
    },
    unit = {
      count = 70, time = 30,
      ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
    },
    prerequisites = {"fluid-handling"},
  },
})
util.add_unlock("chlorine-processing", "ferric-chloride")
util.add_unlock("chlorine-processing", "ferric-chloride-hcl")
util.add_unlock("fluid-handling", "chemical-plant")
util.remove_recipe_effect("oil-processing", "chemical-plant")
else
  util.add_unlock("kr-fluids-chemistry", "ferric-chloride")
  util.add_unlock("kr-fluids-chemistry", "ferric-chloride-hcl")
  util.add_unlock("kr-fluids-chemistry", "hydrogen-chloride-salt")
end

if mods.bzgas then
  data:extend({
    {
      type="recipe",
      name="bakelite-hcl",
      localised_name = { "item-name.bakelite" },
      results = {{type="item", name="bakelite", amount=3}},
      ingredients = {
        {type="item", name=data.raw.item["phenol"] and "phenol" or "coal", amount=1},
        {type="fluid", name="formaldehyde", amount=10},
        {type="fluid", name=hcl_name, amount=5},
      },
      icons = {
        {icon = "__bzgas__/graphics/icons/bakelite.png", icon_size=128},
        {icon = "__bzchlorine__/graphics/icons/hcl.png", icon_size=128, scale=0.125, shift={-8,-8}},
      },
      enabled = false,
      category = "chemistry",
      energy_required = 3,
    }
  })
  if mods.Krastorio2 then
    util.add_unlock("kr-advanced-chemistry", "bakelite-hcl")
  else
    util.add_unlock("chlorine-processing", "bakelite-hcl")
  end
end

