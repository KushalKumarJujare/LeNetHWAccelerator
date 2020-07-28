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

The main reason is to break the symmetry in the network and keeps the number of connections within reasonable bounds. That’s why the number of training parameters in this layers are 1516 instead of 2400 and similarly, the number of connections are 151600 instead of 240000.

![image](https://user-images.githubusercontent.com/62478699/88669798-a48c4b00-d0e4-11ea-85eb-4fe0e426bb0b.png)

Fourth Layer:

The fourth layer (S4) is again an average pooling layer with filter size 2×2 and a stride of 2. This layer is the same as the second layer (S2) except it has 16 feature maps so the output will be reduced to 5x5x16.

![image](https://user-images.githubusercontent.com/62478699/88669990-d7364380-d0e4-11ea-906f-35223df30971.png)

Fifth Layer:

The fifth layer (C5) is a fully connected convolutional layer with 120 feature maps each of size 1×1. Each of the 120 units in C5 is connected to all the 400 nodes (5x5x16) in the fourth layer S4.

![image](https://user-images.githubusercontent.com/62478699/88670129-fd5be380-d0e4-11ea-892e-964b240e43db.png)

Sixth Layer:

The sixth layer is a fully connected layer (F6) with 84 units.

![image](https://user-images.githubusercontent.com/62478699/88670325-36945380-d0e5-11ea-9b55-853e02a157b5.png)

Output Layer:

Finally, there is a fully connected softmax output layer ŷ with 10 possible values corresponding to the digits from 0 to 9.

![image](https://user-images.githubusercontent.com/62478699/88670446-5deb2080-d0e5-11ea-8758-2b4e9b3dc4d7.png)

![image](https://user-images.githubusercontent.com/62478699/88670592-8b37ce80-d0e5-11ea-8d06-a11839653f08.png)

