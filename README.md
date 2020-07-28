# LeNetHWAccelerator
Design and implement a hardware accelerator for LeNet Inference CNN structure in SV, following the Data-flow architecture.

# Introduction
Yann LeCun, Leon Bottou, Yosuha Bengio and Patrick Haffner proposed a neural network architecture for handwritten and machine-printed character recognition in 1990’s which they called LeNet-5.

![image](https://user-images.githubusercontent.com/62478699/88668530-0946a600-d0e3-11ea-845b-e27e4a501131.png)

The LeNet-5 architecture consists of two sets of convolutional and average pooling layers, followed by a flattening convolutional layer, then two fully-connected layers and finally a softmax classifier.

First Layer:

The input for LeNet-5 is a 32×32 grayscale image which passes through the first convolutional layer with 6 feature maps or filters having size 5×5 and a stride of one. The image dimensions changes from 32x32x1 to 28x28x6.

![image](https://user-images.githubusercontent.com/62478699/88668917-86721b00-d0e3-11ea-93df-a43fdeaeb533.png)

Second Layer:

Then the LeNet-5 applies average pooling layer or sub-sampling layer with a filter size 2×2 and a stride of two. The resulting image dimensions will be reduced to 14x14x6.

![image](https://user-images.githubusercontent.com/62478699/88669212-e7015800-d0e3-11ea-9799-36fae2fe0e8d.png)

Third Layer:

Next, there is a second convolutional layer with 16 feature maps having size 5×5 and a stride of 1. In this layer, only 10 out of 16 feature maps are connected to 6 feature maps of the previous layer as shown below.

![image](https://user-images.githubusercontent.com/62478699/88669630-6a22ae00-d0e4-11ea-83cb-c18a81f25edc.png)

