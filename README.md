# Cyclops
Real time digital image processing in a Cyclone IV FPGA, using the DE0 Nano development board and OV7670 camera module.

Filters are changed in real time with the board's buttons.
## General Setup
<img src="./support/gif.gif" width=500>

## High-Boost
<img src="./support/high-boost.JPG" width=300>

## Laplacian
<img src="./support/laplacian.JPG" width=300>

## Laplacian + Opening
<img src="./support/laplacian+opening.JPG" width=300>

## All-pass (No processing)
<img src="./support/wire.jpeg" width=300>

## Low-pass
<img src="./support/low-pass.jpg" width=300>

## Sobel
<img src="./support/sobel.JPG" width=300>

## Block Diagram
![Alt text](./design/presentation.jpg?raw=true "Project scheme")

## Buffering
Since we are using the limited M9K blocks available in the FPGA, we can't buffer a whole frame from the camera data. The following scheme is implemented, where we store 4 rows of data, use the oldest 3 to apply the kernel (green) and write in the last one (red):
![Alt text](./design/buffering.jpg?raw=true "Project scheme")


## Project's directory structure
* **design/**: Contains design documents such as drawings, diagrams or schemes
* **quartus/**: Contains the Quartus project
    * **hdl/**: VHDL files used for custom modules
    * **bdf/**: Modules designed schematically
    * **symbols/**: Symbols generated for created modules
* **reference/**: Contains reference documents such as component datasheets or application notes
* **miscellaneous/**: Contains some general files and documents
* **support/**: Contains 



