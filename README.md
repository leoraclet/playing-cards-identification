# Playing Card Identification

This project implements a **playing card identification system** using **MATLAB/Octave**. It leverages standard image processing techniques and algorithms to extract key information, including:

- Number of cards
- Card values
- Card positions (*used to display their value at the end*)

## 📦 Project Structure

```text
├── assets/             # Illustrations of the process
├── src/                # Functions and main program
|   └── samples         # Sample images
└── flake.nix           # Nix environment
```

> [!important]
> Currently, the code is extensively commented **only in French**.
>
> English translations will be added in the future.

## ⚙️ How It Works

The playing card identification process follows these steps:

1. **Image Loading and Grayscale Conversion**
   The input image is loaded and converted to grayscale.

2. **Thresholding**
   A threshold is applied to create a binary (black and white) image, distinguishing the cards from the background.

3. **Dilation**
   Successive dilation operations are applied to fill the cards completely.

4. **Card Segmentation**
   A 3-pass segmentation process identifies the number of cards and their positions, assigning unique pixel values to each card.

5. **Design Extraction**
   The inverse of the thresholded image is taken to isolate the card designs. Refining this image with dilation and erosion operations preserves only the interior designs of the cards.

6. **Symbol Segmentation**
   The designs are segmented to isolate individual symbols.

7. **Symbol-to-Card Association**
   The barycenter (center of mass) of each symbol is calculated. Using the segmented card image (from step 4), each symbol is associated with its respective card based on the barycenter's location.

8. **Card Value Determination**
   The number of symbols per card is counted, determining the card values.

9. **Result Visualization**
   The barycenter of each card (from step 4) is used to overlay text on the image, displaying the card values and producing the final result.

### Steps Summary

Below are the steps illustrated with images from each stage of the image processing pipeline.

|         Step 1 - Grey image         |     Step 2 - Black and White image      |
| :---------------------------------: | :-------------------------------------: |
|  ![Step1](./assets/card-grey.png)   | ![Step2](./assets/card-black-white.png) |
|     **Step 3 - Dilated cards**      |      **Step 4 - Segmented cards**       |
| ![Step3](./assets/card-dilated.png) |     ![Step4](./assets/card-seg.png)     |
|    **Step 5 - Dilated designs**     |     **Step 6 - Segmented designs**      |
| ![Step5](./assets/part-dilated.png) |    ![Step6](./assets/parts-seg.png)     |
|             **Result**              |           **Original image**            |
|   ![Result](./assets/result.png)    |   ![Original](./assets/original.png)    |

## 🚧 Limits

This image processing approach is designed to work only for cards with values from **1 (Ace) to 10**. High-rank cards (King, Queen, Jack) have more complex designs that do not directly correspond to their numerical value, so they are not supported by this method.

## 🧪 Testing the Project

Begin by cloning the repository and navigating into the project directory:

```bash
git clone https://github.com/leoraclet/playing-cards-identification
cd playing-cards-identification
```

### 📥 Installation

Ensure [Octave](https://octave.org/download) is installed on your system.

#### Nix Users

If you use the Nix package manager with `direnv`, enable the environment by running:

```bash
direnv allow
```

### ✅ Running the Pipeline

1. Launch Octave:
   ```bash
   octave
   ```

2. Install the required `image` package and execute the main script:
   ```bash
   pkg install image
   run src/Traitement.m
   ```

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
