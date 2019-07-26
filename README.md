# Sparse Representation

## Introduction

Courses by edX, IsraelX, The Technion and Michael Elad:

- Sparse Representations in Image Processing: Fundamentals
- Sparse Representations in Image Processing: From Theory to Practice

Learn the theory, tools and algorithms of sparse representations and their impact on signal and image processing.

An important topic related with many technical areas including imaging, computer vision,
statistical science, and machine learning.

### Topics

1. Fundamental theoretical contributions of sparse representation theory.
2. The importance of models in data processing.
3. Dictionary learning algorithms and their role in using this mode.
4. How to deploy sparse representations to signal and image processing tasks.

## Content

### Project 1 - Pursuit Algorithms

**Mid-project**

- Demonstrate the Orthogonal Matching Pursuit (OMP) and Basis Pursuit (BP) algorithms by running them on a set of test signals and checking whether they provide the desired outcome for the  P<sub>0</sub>  problem

1. Data construction
2. Greedy Pursuit
3. Basis Pursuit
4. Analyzing the Results


### Project 2 - Image Inpainting and Testing Various Pursuit Methods

**Final project**

- In this project we solve a variant of the P<sub>0</sub><sup>&#1013;</sup> for filling-in missing pixels
(also known as “inpainting”) in a synthetic image.

1. Data construction
2. Inpainting by the Oracle Estimator
3. Inpainting by Greedy Pursuit
4. Inpainting by Basis Pursuit
5. Effect of Parameters


### Project 3 - Unitary Dictionary Learning

**Mid-project**

- Train a unitary dictionary via the Procrustes analysis for representing image patches, and compare its performance to the Discrete Cosine Transform (DCT).


### Project 4 - Image Denoising

**Final project**

- Denoise a corrupted image using both the DCT and a learned unitary dictionary.
- Relies on the first project in order to obtain the learned dictionary.
- Improve the patch-based denoising algorithm using a technique known as the SOS boosting.

1. Data Construction and Parameter-Setting
2. DCT Dictionary
3. Procrustes Dictionary Learning
4. Boosting


### Project 5 - Image Deblurring

**Bonus project**

- Use the DCT denoising algorithm, which you have implemented in Project 2,
to tackle an image deblurring problem.
- Use the Regularization by Denoising (RED) framework.

1. Data construction
2. Deblurring via Regularization by Denoising (RED)


