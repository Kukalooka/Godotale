extends Control

class_name BattleUi

@onready var lastActive = $FightButton

@export_file("*.wav") var uiMoveSfx : String
@export_file("*.wav") var uiConfirmSfx : String


func _ready():
	$FightButton.grab_focus()
	for x in get_children():
		if "button" in x.name.to_lower():
			if x.has_signal("pressed"):
				x.focus_entered.connect(func ():
					$AudioStreamPlayer2D.stream = load(uiMoveSfx)
					$AudioStreamPlayer2D.play()
				)
				x.pressed.connect(func ():
					$AudioStreamPlayer2D.stream = load(uiConfirmSfx)
					$AudioStreamPlayer2D.play()
				)

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

func changeActivity(button):
	lastActive.get_node("Active").visible = false
	lastActive.get_node("Inactive").visible = true
	
	button.get_node("Active").visible = true
	button.get_node("Inactive").visible = false
	
	lastActive = button

func _on_fight_button_focus_entered() -> void:
	changeActivity($FightButton)
	pass 


func _on_mercy_button_focus_entered() -> void:
	changeActivity($MercyButton)
	pass # Replace with function body.


func _on_item_button_focus_entered() -> void:
	changeActivity($ItemButton)
	pass # Replace with function body.


func _on_act_button_focus_entered() -> void:
	changeActivity($ActButton)
	pass # Replace with function body.
