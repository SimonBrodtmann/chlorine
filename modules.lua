local util = require("data-util");

for i, recipe in pairs(util.me.recipes) do
  if data.raw.recipe[recipe] then
    data.raw.recipe[recipe].allow_productivity = true
  end
end
