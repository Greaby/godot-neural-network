extends Node2D

var nn: NeuralNetwork

var inputs = [
	[[0,0], [0]],
	[[0,1], [1]],
	[[1,0], [1]],
	[[1,1], [0]]
]

func _ready() -> void:
	randomize()
	nn = NeuralNetwork.new(2, 4, 1)

func _process(delta: float) -> void:
	for i in range(200):
		var input = inputs[randi() % inputs.size()]
		nn.train(input[0], input[1])

	update()

func _draw() -> void:
	var size = 20
	var square = 20.0
	
	for x in range(square+1):
		for y in range(square+1):
			var x_value = x/square
			var y_value = y/square
			var rect = Rect2(Vector2(x*size, y*size), Vector2(size, size))
			var result = nn.predict([x_value, y_value])
			var color = Color(result[0], result[0], result[0])
			draw_rect(rect, color)
