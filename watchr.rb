ENV["WATCHR"] = "1"
system 'clear'

def run(cmd)
  puts(cmd)
  system(cmd)
end

def growl(result)
  message = result ? "OK" : "FAILED"
  growlnotify = `which notify-send`.chomp
  title = "Watchr Test Results"
  image = (result) ? ".watchr_images/passed.png" : ".watchr_images/failed.png"
  options = %("#{title}" "#{message}" -i #{File.expand_path(image)})
  system %(#{growlnotify} #{options} &)
end

watch( /spec\/(.+)_spec.rb|(.+).rb/ ) do |md|
  system 'clear'
  result = run("rspec spec/#{md[1] || md[2]}_spec.rb")
  growl result
  puts ("\n\n")
end
