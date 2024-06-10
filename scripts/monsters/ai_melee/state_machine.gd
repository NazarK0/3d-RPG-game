extends Node
class_name StateMachine

var state: Dictionary = {
	"Idle": preload("res://scripts/monsters/ai_melee/idle_state.gd"),
	"Run": preload("res://scripts/monsters/ai_melee/run_state.gd"),
	"Attack": preload("res://scripts/monsters/ai_melee/attack_state.gd"),
	"Death": preload("res://scripts/monsters/ai_melee/death_state.gd"),
}

#func _ready() -> void:
	#changeState("Idle")

func changeState(new_state: String) -> void:
	if get_child_count() != 0:
		get_child(0).queue_free()
		
	if state.has(new_state): 
		var state_temp: Node = state[new_state].new()
		
		state_temp.name = new_state
		print(state_temp)
		add_child(state_temp)
	
