# Pry config to work with RubyMine
Pry.config.editor = proc { |file, line| "mine --line #{line} #{file}" }%
