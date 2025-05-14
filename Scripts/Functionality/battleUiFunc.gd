extends Control

class_name BattleUi

func _ready():
	$FightButton.grab_focus()

func changeHpBar(curHp):
	$HP_Bar.value = curHp
	
func changeUiState(state):
	var focus := Control.FOCUS_ALL
	if state:
		focus = Control.FOCUS_NONE
	
	$FightButton.focus_mode = focus
	$ActButton.focus_mode = focus
	$ItemButton.focus_mode = focus
	$MercyButton.focus_mode = focus
	$FightButton.grab_focus()
