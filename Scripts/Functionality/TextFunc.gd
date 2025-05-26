extends Control

class_name TextboxSystem

@export_file("*.wav") var defaultSound : String
@export var battleBox : BattleBox
@export var player : PlayerHeart

func _writeToBox(text : String, interval, sound):
	$AudioStreamPlayer2D.stream = load(sound)
	for x in range(len(text)):
		$RichTextLabel.text += text[x]
		if text[x] != " ":
			$AudioStreamPlayer2D.play()
		await get_tree().create_timer(interval).timeout
		
		
func invokeTextbox(text, interval=0.05, sound=defaultSound):
	player.updatePlayerState(0)
	$RichTextLabel.text = ""
	if await battleBox.resizeBox(size.x + 4, size.y):
		_writeToBox(text, interval, sound)
	
