extends TextboxSystem

class_name BattleTextbox

@export var battleBox : BattleBox
@export var player : PlayerHeart

func invokeBattleText(text, interval=0.05, sound=defaultSound):
	player.updatePlayerState(0)
	$RichTextLabel.text = ""
	if await battleBox.resizeBox(size.x + 4, size.y):
		_writeToBox(text, interval, sound)
