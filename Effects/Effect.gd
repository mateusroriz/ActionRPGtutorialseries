extends AnimatedSprite


func _ready():
	self.connect("animation_finished", self, "_on_animation_finished") #connecting the signal thorugh code
	frame = 0
	play("Animate")


func _on_animation_finished():
	queue_free()
