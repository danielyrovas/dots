local status_ok, esc = pcall(require, 'better_escape')
if not status_ok then
  return
end

esc.setup {
  mapping = { "lh"},
}
