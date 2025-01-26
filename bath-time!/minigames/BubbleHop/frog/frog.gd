extends Node2D

var weight = 0; 

var size = 1;

func gain_weight(node_weight):
	weight += node_weight;
	size += 1;
	
func get_weight():
	return weight;
