function pprint(v)
  print("-----------------------------")
  print(v)
  print(type(v))
  print("-----------------------------")
end

function ppl()
  print("-----------------------------")
end

function string2url(s)
  return (string.gsub(s, "([^A-Za-z0-9_.])", function(c)
      return string.format("%%%02x", string.byte(c))
  end))
end

-- Define lang replacement rules
local lang_replacements = {
  python = "&py=311",
  cpp = "&py=cpp_g%2B%2B9.3.0",
  c = "&py=c_gcc9.3.0",
  java = "&py=java",
  js = "&py=js",
}


---@param el pandoc.CodeBlock
---@return pandoc.CodeBlock | pandoc.RawInline
local function VisualizeCodeCell(el)
      
  local str = el.attr.classes[1]
  local width = el.attr.attributes.width or width_default
  local height = el.attr.attributes.height or height_default
  -- print(width)
  -- print(height)
  -- ppl()

  -- print(str)
  -- local pattern = "^{visualize-(C|python)}$"
  -- local pattern = "{visualize%-%w+}"
  local pattern = "{visualize%-(%w+)}"
  -- local pattern = "{visualize-(python|c|cpp)}"
  if str then
    local lang = string.match(str, pattern)
    local code = el.text
    -- quarto.log.output(el)
    local code_before = "https://pythontutor.com/iframe-embed.html#code="
    if lang then
      lang = lang_replacements[lang]
      -- local curInstr = 0
      -- if lang == "&py=js" then
      --   curInstr = 6
      -- end
      local code_after = "&codeDivHeight=400&codeDivWidth=350&cumulative=false&curInstr=0&heapPrimitives=nevernest&origin=opt-frontend.js" .. lang .. "&rawInputLstJSON=%5B%5D&textReferences=false"
      -- code = code:gsub("\\n", "\n")
      code = string2url(code)
      -- pprint(code_before .. code .. code_after)
      local iframe = string.format(
        '<iframe width="%s" height="%s" frameborder="0" src="%s"> </iframe>', width, height,
        code_before .. code .. code_after
      )
      return pandoc.RawBlock('html', iframe)
    end
    -- pprint(code)    
  end
end

function extract_meta(meta)
  ---@type string
  width_default = "100%"
  -- width_default = pandoc.utils.stringify(meta.width)
  -- pprint(meta.height)
  ---@type string
  height_default = "600"
  -- pprint(pandoc.utils.stringify(meta.width))
  -- if meta.width then 
    -- width_default = pandoc.utils.stringify(meta.width)
    -- pprint(width_default)
  -- end
  -- if meta.height then 
  --   height_default = pandoc.utils.stringify(meta.height)
  --   -- pprint(width_default)
  -- end
  if meta.visualize_code then
    for k, v in pairs(meta.visualize_code) do
      if v.width then 
        width_default = pandoc.utils.stringify(v.width)
      end
      if v.height then 
        height_default = pandoc.utils.stringify(v.height)
      end
    end
  end
  -- pprint(width_default)
  -- pprint(height_default)
end


return {
  {
    Meta = extract_meta
  }, 
  {
    CodeBlock = VisualizeCodeCell
    -- CodeBlock = ttt
  },
  -- {
  --   Pandoc = stitchDocument
  -- }
}
