# Neural Network: Multilayer Perceptron - Godot Engine

This is a follow-up to my first project on the [perceptron](https://github.com/Greaby/godot-perceptron).

To solve non-linear problems, we need to connect several perceptrons together to create a neural network.
In the example, the multilayer perceptron resolve a XOR operation.

The inputs will be propagated between several layers of perceptrons and output a value as a result.

# How to use


Create a new neural network with his number of inputs, hidden layers and outputs.

```gdscript
var neural_network = NeuralNetwork.new(INPUTS, HIDDEN_LAYERS, OUPUTS)
```

To train the neural network, pass the input values and the expected result to the training function.

```gdscript
neural_network.train([INPUT_1, INPUT_X...], EXEPTED_RESULT)
```
