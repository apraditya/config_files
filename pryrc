# Pry config to work with RubyMine
# Pry.config.editor = proc { |file, line| "mine --line #{line} #{file}" }
Pry.config.editor = 'atom'
Pry.config.correct_indent = false
Pry.config.auto_indent = false


# Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end

  def interesting_methods
    case self.class
    when Class
      self.public_methods.sort - Object.public_methods
    when Module
      self.public_methods.sort - Module.public_methods
    else
      self.public_methods.sort - Object.new.public_methods
    end
  end
end

# copy a string to the clipboard
def pbcopy(string)
  `echo "#{string}" | pbcopy`
  string
end
