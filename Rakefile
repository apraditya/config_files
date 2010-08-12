require 'rake'
require 'erb'

MiscPlugins = %w( snipmate.vim Command-T )
ResourcesDir = 'vim-resources'
IGNORE = [ /\.gitignore$/, /Rakefile$/, /LICENSE$/i, /README\.?/i ]

desc "Install the config files into user's home directory"
task :install do
  replace_all = false
  Dir[ '*' ].each do |file|
    next if %w[ Rakefile README.rdoc LICENSE ].include? file

    if File.exist?( File.join(ENV['HOME'], ".#{file.sub('.erb', '')}") )
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub('.erb', '')}" )
        puts "identical ~/.#{file.sub('.erb', '' )}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub('.erb', '')} ? [ ynaq ]"
        case $stdin.gets.chomp
        when 'q'
          exit
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        else
          puts "skipping ~/.#{file.sub('.erb', '' )}"
        end
      end
    else
      link_file(file)
    end
  end # of Dir[ '*' ]
end # of task :install

namespace :vim do
  desc "Install all vim plugins in #{ResourcesDir} directory"
  task :install_all_plugins do
    Dir["#{ResourcesDir}/*"].each do |plugin_dir|
      plugin = plugin_dir.gsub("#{ResourcesDir}/", '')
      install_vim_plugin(plugin)
    end
  end

  desc "Update all vim plugins in #{ResourcesDir} directory"
  task :update_all_plugins do
    Dir["#{ResourcesDir}/*"].each do |plugin_dir|
      plugin = plugin_dir.gsub("#{ResourcesDir}/", '')
      update_vim_plugin(plugin)
    end
  end

  desc "Remove all vim plugins in #{ResourcesDir} directory"
  task :remove_all_plugins do
    Dir["#{ResourcesDir}/*"].each do |plugin_dir|
      plugin = plugin_dir.gsub("#{ResourcesDir}/", '')
      remove_vim_plugin(plugin)
    end
  end

  desc "Install vim plugin specified in the arguments"
  task :install_plugin, :plugin_name do |task, arg|
    install_vim_plugin(arg[:plugin_name])
  end

  desc "Uninstall specified vim plugin"
  task :remove_plugin, :plugin_name do |task, arg|
    remove_vim_plugin(arg[:plugin_name])
  end

  desc "Update vim plugins by pulling from their origin repository"
  task :update_plugin, :plugin_name do |task, arg|
    update_vim_plugin(arg[:plugin_name])
  end

end


# FUNCTIONS

def update_vim_plugin(plugin_name)
  # Checks the existance
  submodule = "#{ResourcesDir}/#{plugin_name}"
  if File.exist? submodule
    puts "Pulling from the #{plugin_name} plugin repository.."
    system %Q{ cd "#{submodule}" && git pull }
  else
    puts "#{plugin_name} not found or has not been added as a submodule"
  end
end

def remove_vim_plugin(plugin_name)
  # Checks the existance
  submodule = "#{ResourcesDir}/#{plugin_name}"
  if File.exist? submodule
    if MiscPlugins.include? plugin_name
      puts "Removing #{plugin_name} plugin is currently not supported with this command"
    else
      puts "Removing plugin: #{plugin_name}"
      remove_vim_plugin_links(submodule)
    end
  end
end

def remove_vim_plugin_links(module_dir)
  plugin_files = get_plugin_files(module_dir)
  plugin_files.each do |file|
    target = "vim/#{file}"
    if File.exist? target
      puts "removing #{target}"
      system %Q{ rm -f "#{target}" }
    else
      puts "#{target} not found"
    end
  end
end

def install_vim_plugin(plugin_name)
  # Checks the existance
  submodule = "#{ResourcesDir}/#{plugin_name}"
  if File.exist? submodule
    if MiscPlugins.include? plugin_name
      puts "Installing #{plugin_name} plugin is currently not supported with this command"
    else
      puts "Installing plugin: #{plugin_name}"
      system %Q{ git submodule update "#{submodule}" } if Dir["#{submodule}/*"].size == 0
      link_vim_plugin_files(submodule)
    end
  else
    puts "#{plugin_name} not found or has not been added as a submodule"
  end

end

def link_vim_plugin_files(module_dir)
  replace_all = false
  plugin_files = get_plugin_files(module_dir)
  plugin_files.each do |file|
    target_dir = "vim/#{File.dirname(file)}"
    system %Q{ mkdir -p "#{target_dir}" } unless File.exist? target_dir
    source = "#{module_dir}/#{file}"
    target = "vim/#{file}"
    if File.exist? target
      if File.identical? source, target
        puts "identical #{target}"
      elsif replace_all
        replace(source, target)
      else
        print "overwrite #{target} ? [ ynaq ]"
        case $stdin.gets.chomp
        when 'q'
          exit
        when 'a'
          replace_all = true
          replace(source, target)
        when 'y'
          replace(source, target)
        else
          puts "skipping #{target}"
        end
      end
    else
      internal_link(source, target)
    end
  end
  
end

def get_plugin_files(repo_dir)
  files = `cd "#{repo_dir}" && git ls-files`.split("\n")
  files.reject! { |file| IGNORE.any? { |re| file.match(re) } }
  files
end

def replace(source, target)
  system %Q{ rm -f "#{target}" }
  internal_link(source, target)
end

def internal_link(source, target)
  puts "linking #{source} to #{target}"
  system %Q{ ln -s "$PWD/#{source}" "#{target}" }
end


def replace_file(file)
  system %Q{ rm -rf "$HOME/.#{file.sub('.erb', '' )}" }
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '' )}"
    File.open( File.join( ENV['HOME'], ".#{file.sub('.erb', '' )}"), 'w' ) do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ ln -s "$PWD/#{file}" "$HOME/.#{file}" }
  end
end
