input = STDIN.gets

stack = []
stack_depth = 0

def close_bracket(stack)
  words = [""]
  word = stack.pop
  while word != '('
    if word == '|'
      words << ""
    else
      words[words.length-1] = word + words.last
    end
    word = stack.pop
  end
  stack.push words.sample
end

input.scan(/\(|\)|\||[^\(\)\|]+/) do |token|
  # puts "stack is: #{stack.inspect}, token is: #{token.inspect}"
  case token
  when '('
    stack_depth += 1
    stack.push '('
  when ')'
    stack_depth -= 1
    if stack_depth < 0
      raise "Unbalanced brackets"
    end
    close_bracket(stack)
  when '|'
    stack.push '|'
  else
    stack.push token
  end
end

puts stack.join
