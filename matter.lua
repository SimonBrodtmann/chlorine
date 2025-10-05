-- Matter recipes for Krastorio2
if mods["Krastorio2"] then
  local matter = require("__Krastorio2__/prototypes/libraries/matter");
  local salt_matter = {
    material = { type = "item", name = "salt", amount = 1 },
    matter_count = 2,
    energy_required = 1,
    need_stabilizer = false,
    unlocked_by_technology = "salt-matter-processing",
  }
  matter.make_recipes(salt_matter)
end
