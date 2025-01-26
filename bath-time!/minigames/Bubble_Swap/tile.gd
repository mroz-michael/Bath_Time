extends Sprite2D

@export var tile_without_bubble : Texture2D  
@export var tile_with_bubble : Texture2D


var val = 1; #1 => has bubble

func set_val(new_val):
	val = new_val;
	update_texture();

func has_bubble():
	return val == 1;
	
func swap_val():
	val = 0 if has_bubble() else 1;
	update_texture();
	
func update_texture():
	self.texture = tile_with_bubble if has_bubble() else tile_without_bubble;
		
