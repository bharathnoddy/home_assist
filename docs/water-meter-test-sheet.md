# Water Meter Test Sheet - For ESP32-CAM Training

## Instructions for Creating Test Images

Since we need realistic water meter images for testing, here are two options:

### Option 1: Use Real Water Meter Images (Recommended)

Download sample water meter images from these sources:

1. **Google Images Search:**
   ```
   "analog water meter close up"
   "water meter dials"
   "mechanical water meter reading"
   ```

2. **Print 4-5 different images** on A4 paper showing different readings

3. **Good test images should show:**
   - Clear digits (0-9)
   - Multiple dials or digit wheels
   - Good contrast (black numbers on white background)
   - Different readings (so AI learns variations)

### Option 2: Create Simple Test Numbers

If you can't find good images, create a simple A4 sheet with large numbers:

## Test Sheet Layout (Copy to Word/Pages and Print)

---

### WATER METER TEST - Reading 1
```
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
│  0  │  0  │  1  │  2  │  3  │  4  │  5  │  6  │
└─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘
        Reading: 12.3456 m³
```

---

### WATER METER TEST - Reading 2
```
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
│  0  │  0  │  1  │  2  │  3  │  6  │  8  │  9  │
└─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘
        Reading: 12.3689 m³
```

---

### WATER METER TEST - Reading 3
```
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
│  0  │  0  │  1  │  2  │  4  │  1  │  2  │  3  │
└─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘
        Reading: 12.4123 m³
```

---

### WATER METER TEST - Reading 4
```
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
│  0  │  0  │  1  │  2  │  5  │  7  │  8  │  9  │
└─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘
        Reading: 12.5789 m³
```

---

### WATER METER TEST - Reading 5
```
┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┐
│  0  │  0  │  1  │  3  │  0  │  0  │  0  │  0  │
└─────┴─────┴─────┴─────┴─────┴─────┴─────┴─────┘
        Reading: 13.0000 m³
```

---

## Better Option: Download Real Images

I recommend searching for and downloading actual water meter photos. Here's a good search query:

**Google Images:** `"Vitens water meter" OR "analog water meter digits" OR "mechanical water meter close up"`

Save 4-5 different images showing different readings, then print them on A4 paper.

## Tips for Testing

1. **Print at good size** - digits should be about 1-2cm tall
2. **Mount on flat surface** - tape to wall or desk
3. **Good lighting** - avoid shadows and glare
4. **Position ESP32-CAM** 10-15cm away
5. **Take photos** and practice drawing ROI boxes

## What You'll Learn

- How to position the camera
- How to define ROI (Region of Interest) boxes
- How the OCR recognition works
- How to train the neural network
- Troubleshooting before real installation

Once you're comfortable with the test setup, you can install it on your actual water meter!
