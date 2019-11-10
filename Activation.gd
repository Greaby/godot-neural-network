extends Node
class_name Activation

static func sigmoid(value, row, col):
	return 1 / (1 + exp(-value))

static func dsigmoid(value, row, col):
	return value * (1 - value)
