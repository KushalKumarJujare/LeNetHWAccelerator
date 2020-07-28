# LeNetHWAccelerator
Design and implement a hardware accelerator for LeNet Inference CNN structure in SV, following the Data-flow architecture.

# Introduction
Yann LeCun, Leon Bottou, Yosuha Bengio and Patrick Haffner proposed a neural network architecture for handwritten and machine-printed character recognition in 1990’s which they called LeNet-5.

![image](https://user-images.githubusercontent.com/62478699/88668530-0946a600-d0e3-11ea-845b-e27e4a501131.png)

The LeNet-5 architecture consists of two sets of convolutional and average pooling layers, followed by a flattening convolutional layer, then two fully-connected layers and finally a softmax classifier.

First Layer:

The input for LeNet-5 is a 32×32 grayscale image which passes through the first convolutional layer with 6 feature maps or filters having size 5×5 and a stride of one. The image dimensions changes from 32x32x1 to 28x28x6.

