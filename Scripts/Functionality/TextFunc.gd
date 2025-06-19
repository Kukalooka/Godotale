extends Control

class_name TextboxSystem

@export_file("*.wav") var defaultSound : String

var instances = 0
var cancelResponse = 0

func _cancelProcess():
	if instances != 0:
		cancelResponse = 1
		var timer = 0
	
		while cancelResponse < 2:
			timer += 1
			if timer > 10:
				cancelResponse = 2
			await get_tree().process_frame
		
		$RichTextLabel.text = ""
		cancelResponse = 0
		instances -= 1
		
	return true

func _writeToBox(text : String, interval, sound, group):
	instances += 1
	$AudioStreamPlayer2D.stream = load(sound)
	var bracketflag = 0
	var bbcode = ""
	
	for x in range(len(text)): 
		if cancelResponse == 1:
			cancelResponse = 2
			return false
		if text[x] != "[" and bracketflag == 0:
			$RichTextLabel.append_text(text[x])
			if text[x] != " ":
				$AudioStreamPlayer2D.play()
			await get_tree().create_timer(interval).timeout
		else:
			if bracketflag < 1:
				if text[x+1] == "/":
					bracketflag = 2
				else:
					bracketflag = 1
			bbcode += text[x]
			
			if text[x] == "]":
				$RichTextLabel.append_text(bbcode)
				bbcode = ""

				bracketflag = 0
	instances -= 1
	return true
		

	
