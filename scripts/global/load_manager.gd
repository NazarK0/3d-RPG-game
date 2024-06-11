extends Node

signal progress_changed(progress: float)
signal load_done

var _load_screen_path: String = "res://scenes/gui/loading_screen.tscn"
var _load_screen: PackedScene = load(_load_screen_path)
var _loaded_resource: PackedScene
var _scene_path: String
var _progress: Array = []
var _use_sub_threads: bool = true


func _process(_delta: float) -> void:
	var load_status: ResourceLoader.ThreadLoadStatus = (
		ResourceLoader.load_threaded_get_status(_scene_path, _progress)
		)
	
	match load_status:
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_INVALID_RESOURCE, \
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_FAILED:
			print("invalid")
			set_process(false)
			return
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
			print(1)
			emit_signal("progress_changed", _progress[0])
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			print(3)
			_loaded_resource = ResourceLoader.load_threaded_get(_scene_path)
			emit_signal("progress_changed", _progress[0])
			emit_signal("load_done")
			get_tree().change_scene_to_packed(_loaded_resource)


func loadScene(scene_path: String) -> void:
	_scene_path = scene_path
	var new_loading_screen: LoadingScreen = _load_screen.instantiate()
	
	get_tree().get_root().add_child(new_loading_screen)
	
	self.progress_changed.connect(new_loading_screen._updateProgressBar)
	self.load_done.connect(new_loading_screen._startOutroAnimation)
	
	await Signal(new_loading_screen, "loading_screen_has_full_coverage")
	
	startLoad()
	
func startLoad() -> void:
	var state: Error = ResourceLoader.load_threaded_request(_scene_path, "", _use_sub_threads)
	
	if state == OK:
		set_process(true)
