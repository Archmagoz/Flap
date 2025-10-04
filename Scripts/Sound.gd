extends Node2D

# Sounds preload
const FLAP_SONG: Resource = preload("res://Player/Sounds/wing.ogg")
const HIT_SONG: Resource = preload("res://Player/Sounds/hit.ogg")
const POINT_SOUND: Resource = preload("res://Level/Sounds/point.ogg")

# Create temp player, play and delete
func play_sound(sound: AudioStream) -> void:
	var temp_player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	temp_player.stream = sound
	temp_player.connect("finished", Callable(temp_player, "queue_free"))
	
	add_child(temp_player)
	temp_player.play()

# Easy acess sounds
func flap() -> void:
	play_sound(FLAP_SONG)

func hit() -> void:
	play_sound(HIT_SONG)

func point() -> void:
	play_sound(POINT_SOUND)
