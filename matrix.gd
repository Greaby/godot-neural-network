extends Node
class_name Matrix


var cols
var rows
var data = []

func _init(_cols: int, _rows: int):
	cols = _cols
	rows = _rows
	for col in range(cols):
		data[col] = []
		for row in range(rows):
			data[col][row] = 0


func rand(matrix: Matrix):
	for col in range(matrix.cols):
		for row in range(matrix.rows):
			matrix.data[col][row] = randf()

static func add(a: Matrix, b: Matrix):
	assert a.cols == b.cols and a.rows == b.rows
	
	var new_matrix = Matrix.new(a.cols, a.rows)
	
	for col in range(new_matrix.cols):
		for row in range(new_matrix.rows):
			new_matrix.data[col][row] = a.data[col][row] + b.data[col][row]
			
	return new_matrix
	
static func substract(a: Matrix, b: Matrix):
	assert a.cols == b.cols and a.rows == b.rows
	
	var new_matrix = Matrix.new(a.cols, a.rows)
	
	for col in range(new_matrix.cols):
		for row in range(new_matrix.rows):
			new_matrix.data[col][row] = a.data[col][row] - b.data[col][row]
			
	return new_matrix
	
static func product(a: Matrix, b: Matrix):
	assert a.cols == b.rows and a.rows == b.cols
	
	var new_matrix = Matrix.new(a.cols, a.rows)
	
	for col in range(new_matrix.cols):
		for row in range(new_matrix.rows):
			new_matrix.data[col][row] = a.data[col][row] - b.data[col][row]
			
	return new_matrix

static func transpose(matrix: Matrix):
	var new_matrix = Matrix.new(matrix.rows, matrix.cols)
	
	for col in range(matrix.cols):
		for row in range(matrix.rows):
			new_matrix.data[row][col] = matrix.data[col][row]
	
	return new_matrix
	






