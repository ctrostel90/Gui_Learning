extends Sprite


func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == BUTTON_LEFT:
		print(to_global(get_rect().position))
		print(to_local(event.position))
		if get_rect().has_point(to_local(event.position)):
			print('test')
			get_tree().set_input_as_handled() # if you don't want subsequent input callbacks to respond to this input
