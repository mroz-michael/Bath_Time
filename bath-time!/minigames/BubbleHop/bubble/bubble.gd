extends Node

var max_weight = 0;

func assign_max_weight(weight):
	max_weight = weight;
	
func get_max_weight():
	return max_weight;
	
func receive_weight(incoming_weight):
	if (incoming_weight > get_max_weight()):
		pop();

func pop():
	hide();
