#!/usr/bin/env ruby
# encoding: utf-8

# <bitbar.title>Show Connected Cameras</bitbar.title>
# <bitbar.version>1.0</bitbar.version>
# <bitbar.author>Koichiro Eto</bitbar.author>
# <bitbar.author.github>eto</bitbar.author.github>
# <bitbar.desc>Displays the number of cameras connected.</bitbar.desc>
# <bitbar.image>https://raw.githubusercontent.com/eto/show_cameras/master/show_cameras.png</bitbar.image>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/eto/show_cameras</bitbar.abouturl>

# % system_profiler SPCameraDataType
# Camera:
# 
#     FaceTime HDカメラ（内蔵）:
# 
#       Model ID: UVC Camera VendorID_1452 ProductID_34068
#       Unique ID: 0x8020000005ac8514
# 
# % 

def get_cameras
  system "system_profiler SPCameraDataType >& /tmp/cameras"
  str = ""
  open("/tmp/cameras", "r:UTF-8") {|f|
    str = f.read
  }
  cameras = []
  str.each_line {|line|
    line.chomp!
    if line =~ /^    (.+):$/
      cameras << $1
    end
  }
  return cameras
end

def display_cameras
  cameras = get_cameras
  num = cameras.length
  puts "📷×#{num}"
  puts "---"
  cameras.each {|camera|
    puts camera
  }
end
display_cameras
