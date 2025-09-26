extends AudioStreamPlayer2D

const FLAP_SONG: Resource = preload("res://Player/Sounds/wing.ogg")
const HIT_SONG: Resource = preload("res://Player/Sounds/hit.ogg")
const POINT_SOUND: Resource = preload("res://Level/Sounds/point.ogg")

func play_sound(sound: AudioStream) -> void:
	stream = sound
	play()

func flap() -> void:
	play_sound(FLAP_SONG)

func hit() -> void:
	play_sound(HIT_SONG)

func point() -> void:
	play_sound(POINT_SOUND)
