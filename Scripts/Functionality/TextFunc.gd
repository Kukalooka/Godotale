extends Control

class_name TextboxSystem

@export_file("*.wav") var defaultSound : String

func _writeToBox(text : String, interval, sound):
	$AudioStreamPlayer2D.stream = load(sound)
	for x in range(len(text)):
		$RichTextLabel.text += text[x]
		if text[x] != " ":
			$AudioStreamPlayer2D.play()
		await get_tree().create_timer(interval).timeout
		
		

	
