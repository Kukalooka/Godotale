extends TextboxSystem

class_name BattleTextbox

@export var battleBox : BattleBox
@export var player : PlayerHeart

var token = 0

func invokeBattleText(text, interval=0.05, sound=defaultSound):
	token += 1
	player.updatePlayerState(0)
	$RichTextLabel.text = ""
	if await battleBox.resizeBox(size.x + 4, size.y):
		await _cancelProcess()
		_writeToBox(text, interval, sound, 0)
