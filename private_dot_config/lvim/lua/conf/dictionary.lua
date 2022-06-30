local status_ok, dic = pcall (require, "cmp_dictionary")
if not status_ok then
  return
end
dic.setup {
  dic = {
    ["*"] = { "/usr/share/dict/words"}
  },
  first_case_insensitive = true,
  async = true,
}
