-- Emit an SVG file as raw HTML so Pandoc does not reparse it.
-- A parsed SVG loses quote characters and can be split on blank lines.
function CodeBlock(el)
  if not el.classes:includes("raw-svg") then
    return nil
  end
  local path = el.text:gsub("^%s+", ""):gsub("%s+$", "")
  local handle = io.open(path, "r")
  if not handle then
    error("raw-svg: cannot open " .. path)
  end
  local content = handle:read("*a")
  handle:close()
  return pandoc.RawBlock("html", content)
end
