extends Node2D

var nn

var inputs = [
	[[0,0], [0]],
	[[0,1], [1]],
	[[1,0], [1]],
	[[1,1], [0]]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	nn = NeuralNetwork.new(2, 2, 1)
	

func _process(delta):
	for i in range(100):
		var input = inputs[randi() % inputs.size()]
		nn.train(input[0], input[1])

	update()

func _draw():
	var size = 20
	
	for x in range(10):
		for y in range(10):
			var rect = Rect2(Vector2(x*size, y*size), Vector2(x*size + size, y*size + size))
			var result = nn.predict([x*0.1,y*0.1])
			var color = Color(result[0], result[0], result[0])
			draw_rect(rect, color)
	
	