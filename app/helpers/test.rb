def helper(str)
  new_str = ""
  s = str.split("")
  while s != ""
    if s[0] == "<"
      s.slice!(0..(s.index('>')))
    else
      new_str << s.shift
    end
  end
  new_str
end


a = "<>"
puts helper('<>')