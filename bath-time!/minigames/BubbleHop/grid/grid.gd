const NUM_BUBBLES = 4 #placeholder

const NUM_EDGES = 4 #placeholder

#start by hardcoding a graph, then once things work switch to random generation

#hardcoded graph:

#[
	#[0, 3, 0, 0]     --> node 1 connects to node 2 with weight 3
	#[0, 0, 2, 8]     --> node 2 connects to node 3 w weight 2, node 4 w weight 8
	#[0, 2, 0, 4]
	#[0, 8, 4, 0]
	
#]

const BUBBLES = [];

func create_bubbles():
	for i in range (0, NUM_BUBBLES - 1):
		BUBBLES.append($Bubble.instace());
		
		

const CAPACITY = 42; #replace with longest path from node 1 to node n 

func assign_weights(BUBBLES):
	for (Bubble in BUBBLES):
		
	
	
