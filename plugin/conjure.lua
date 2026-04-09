-- https://github.com/Olical/conjure

---Loads all options related to the conjure plugin
local function load()
  vim.pack.add({ "https://github.com/Olical/conjure" })

  -- Log debugging
  vim.g["conjure#debug"] = true
  -- Disable the documentation mapping
  vim.g["conjure#mapping#doc_word"] = false
  -- Rebind it from K to <prefix>gk
  vim.g["conjure#mapping#doc_word"] = nil
  -- Reset it to the default unprefixed K (note the special table wrapped syntax)
  vim.g["conjure#mapping#doc_word"] = nil
end

vim.api.nvim_create_autocmd('FileType', {
  once = true,
  pattern = { "fennel", "clojure", "janet" },
  callback = load,
})
