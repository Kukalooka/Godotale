extends Control

class_name TextboxSystem

@export_file("*.wav") var defaultSound : String

func _writeToBox(text : String, interval, sound):
	$AudioStreamPlayer2D.stream = load(sound)
	var bracketflag = 0
	var bbcode = ""
	for x in range(len(text)):
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
				print("Textbox: ", $RichTextLabel.text, " BBCode: ", bbcode)
				$RichTextLabel.append_text(bbcode)
				bbcode = ""

				bracketflag = 0
		

	
