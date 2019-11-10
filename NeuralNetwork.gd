extends Node
class_name NeuralNetwork

var input_nodes: int
var hidden_nodes: int
var output_nodes: int

var weights_input_hidden: Matrix
var weights_hidden_output: Matrix

var bias_hidden: Matrix
var bias_output: Matrix

var learning_rate: float

var activation_function
var activation_dfunction

func _init(_input_nodes: int, _hidden_nodes: int, _output_nodes: int):
	input_nodes = _input_nodes;
	hidden_nodes = _hidden_nodes;
	output_nodes = _output_nodes;
	
	weights_input_hidden = Matrix.new(hidden_nodes, input_nodes)
	weights_hidden_output = Matrix.new(output_nodes, hidden_nodes);
	
	bias_hidden = Matrix.new(hidden_nodes, 1);
	bias_output = Matrix.new(output_nodes, 1);
	
	setLearningRate()
	setActivationFunction()


func setLearningRate(_learning_rate: float = 0.01):
	learning_rate = _learning_rate

func setActivationFunction(callback = funcref(Activation, "sigmoid"), dcallback = funcref(Activation, "dsigmoid")):
	activation_function = callback
	activation_dfunction = dcallback

func predict(input_array: Array):
	var inputs = Matrix.fromArray(input_array)
	
	var hidden = Matrix.product(weights_input_hidden, inputs)
	hidden = Matrix.add(hidden, bias_hidden)
	hidden = Matrix.map(hidden, activation_function)

	var output = Matrix.product(weights_hidden_output, hidden)
	output = Matrix.add(output, bias_output)
	output = Matrix.map(output, activation_function)

	return Matrix.toArray(output)


func train(input_array: Array, target_array: Array):
	var inputs = Matrix.fromArray(input_array)
	var targets = Matrix.fromArray(target_array)
	
	var hidden = Matrix.product(weights_input_hidden, inputs);
	hidden = Matrix.add(hidden, bias_hidden)
	hidden = Matrix.map(hidden, activation_function)
	
	var outputs = Matrix.product(weights_hidden_output, hidden)
	outputs = Matrix.add(outputs, bias_output)
	outputs = Matrix.map(outputs, activation_function)
	
	var output_errors = Matrix.subtract(targets, outputs)
	
	var gradients = Matrix.map(outputs, activation_dfunction)
	gradients = Matrix.multiply(gradients, output_errors)
	gradients = Matrix.scalar(gradients, learning_rate)
	
	var hidden_t = Matrix.transpose(hidden)
	var weight_ho_deltas = Matrix.product(gradients, hidden_t)
	
	weights_hidden_output = Matrix.add(weights_hidden_output, weight_ho_deltas)
	bias_output = Matrix.add(bias_output, gradients)
	
	var weights_hidden_output_t = Matrix.transpose(weights_hidden_output)
	var hidden_errors = Matrix.product(weights_hidden_output_t, output_errors)
	
	var hidden_gradient = Matrix.map(hidden, activation_dfunction)
	hidden_gradient = Matrix.multiply(hidden_gradient, hidden_errors)
	hidden_gradient = Matrix.scalar(hidden_gradient, learning_rate)
	
	var inputs_t = Matrix.transpose(inputs)
	var weight_ih_deltas = Matrix.product(hidden_gradient, inputs_t)

	weights_input_hidden = Matrix.add(weights_input_hidden, weight_ih_deltas)

	bias_hidden = Matrix.add(bias_hidden, hidden_gradient)