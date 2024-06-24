extends Node
class_name StateMachine

var state: Dictionary = {
	"Idle": preload("res://monsters/state_machine/idle_state.gd"),
	"Run": preload("res://monsters/state_machine/run_state.gd"),
	"Attack": preload("res://monsters/state_machine/attack_state.gd"),
	"Death": preload("res://monsters/state_machine/death_state.gd"),
}


func changeState(new_state: String) -> void:
	if get_child_count() != 0:
		get_child(0).queue_free()
		
	if state.has(new_state): 
		var state_temp: Node = state[new_state].new()
		
		state_temp.name = new_state
		add_child(state_temp)
	
