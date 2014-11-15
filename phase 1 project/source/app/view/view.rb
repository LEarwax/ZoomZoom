module View
  def self.render(message)
    puts message
  end

  def self.list(array)
    array.each_with_index {|item, index| puts "#{index + 1}. #{item}"}
  end

  def self.welcome_message
    puts "-------------Zoom Zoom-------------"

 #    puts <<-eos
 # __    __    __________                      __________                        __    __
 # \ \   \ \   \____    /____   ____   _____   \____    /____   ____   _____     \ \   \ \
 #  \ \   \ \    /     //  _ \ /  _ \ /     \    /     //  _ \ /  _ \ /     \     \ \   \ \
 #  / /   / /   /     /(  <_> |  <_> )  Y Y  \  /     /(  <_> |  <_> )  Y Y  \    / /   / /
 # /_/   /_/   /_______ \____/ \____/|__|_|  / /_______ \____/ \____/|__|_|  /   /_/   /_/
 #                     \/                  \/          \/                  \/
 #    eos
  end

end
