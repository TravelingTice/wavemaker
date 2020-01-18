# configure options

OPTIONS = {
  duration: 1000
}


def render_hor_line(positions_of_plus, length)
  str = ''

  length.times { str += '-' }

  positions_of_plus.each do |pos|
    str[pos] = '+' if pos < length && !pos.negative?
  end

  str
end

def render_screen(frame)
  height = OPTIONS[:height]
  length = OPTIONS[:length]
  (0..height).each do |line_num|
    positions_array = []
    (0..(OPTIONS[:duration] / height)).each do |i|
      if i.even?
        positions_array << (frame - line_num) - height * i
      else
        positions_array << frame - (height - line_num) - height * i
      end
    end
    puts render_hor_line(positions_array, length)
  end
end

def generator(frame = 0)
  while frame < OPTIONS[:duration]
    system 'clear'

    render_screen(frame)

    sleep(OPTIONS[:speed])

    frame += 1
  end
end

def begin_screen
  system "clear"
  puts "Welcome to the wave maker!"
  puts "What will be the height of your wave?"
  height = gets.chomp

  if height.to_i.zero?
    puts "Kies effe iets anders je"
    return
  end
  # set height
  OPTIONS[:height] = height.to_i

  system "clear"
  puts "And width of the panel"

  width = gets.chomp

  OPTIONS[:length] = width.to_i

  if width.to_i.zero?
    puts "Kies effe iets anders je"
    return
  end

  system "clear"
  puts "What speed would you like? 'slow', 'medium' or 'fast'"
  speed = gets.chomp

  if !(speed == 'slow' || speed == 'medium' || speed == 'fast')
    puts "Ja ik zei nog zo, kies een van die dingen, en wat doe je"
    return
  end


  case speed
  when "fast"
    OPTIONS[:speed] = 0.04
  when "medium"
    OPTIONS[:speed] = 0.08
  when "slow"
    OPTIONS[:speed] = 0.12
  end

  generator
end

begin_screen
