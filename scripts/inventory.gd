extends Control

func cursor_update(holding_item):
	holding_item.global_position = get_global_mouse_position()

