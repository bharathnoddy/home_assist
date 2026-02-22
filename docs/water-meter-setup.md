# DIY Water Meter Reader - Quick Setup Guide

**Project:** ESP32-CAM with AI-on-the-Edge-Device firmware to automatically read analog water meter

**Status:** Part of Phase 3 (parallel with Shelly relay installation)

---

## Overview

Build a camera-based water meter reader that:
- Uses ESP32-CAM (~€20) to photograph analog water meter
- Runs OCR processing on the device (not in Home Assistant)
- Sends readings to Home Assistant via MQTT every 5 minutes
- Achieves 95%+ accuracy after training
- Saves €18-28 vs HomeWizard Water Meter (€50)

---

## Hardware

### Ordered Components
- **ESP32-CAM with USB-C** (~€15-20) - [Amazon.nl link](https://www.amazon.nl/CAM-module-QIQIAZI-ESP-32-CAM-ontwikkelingskaart-TF-kaartmodule/dp/B0DKT9BDBD/)
- **32GB microSD card** (~€7-12) - Class 10 or better (REQUIRED!)
- **3D printed mount** - Custom design in `../3d-models/watermeter-mount.scad`

### At Home
- USB-C cable (USB-A to USB-C for computer)
- USB-C power adapter (5V/1A+ phone charger)
- 3D printer filament (PLA, ~30g)

**Total Cost:** €22-32

---

## Quick Start

### Step 1: Prepare SD Card
```bash
# Format as FAT32 (on Mac)
diskutil list
diskutil eraseDisk FAT32 WATERMETER /dev/diskX

# Or use Disk Utility: Format as MS-DOS (FAT)
```

### Step 2: Flash Firmware
1. Insert SD card into ESP32-CAM
2. Connect USB-C cable to computer
3. Open: https://jomjol.github.io/AI-on-the-edge-device/
4. Click "Connect" → Select serial port
5. Click "Install AI-on-the-Edge-Device"
6. Wait ~5 minutes

### Step 3: Initial Configuration
1. Unplug from computer
2. Power on (via USB-C)
3. Connect to WiFi AP: "AI-on-the-Edge-XXXXX"
4. Browser: http://192.168.4.1
5. Configure your WiFi SSID and password
6. Device reboots and connects to home WiFi

### Step 4: Find Device IP
```bash
# Scan network
arp -a | grep -i esp

# Or check router DHCP leases
```

### Step 5: Access Web Interface
- URL: http://[device-ip]
- Login if prompted (default: admin/admin)

---

## Installation

### 1. Print Mount
```bash
# Open in OpenSCAD
open /Users/bharath.nadar/repo/home_automation/home_assist/3d-models/watermeter-mount.scad

# Adjust parameters:
camera_distance = 120;  // Distance to meter (mm)

# Export STL → Slice → Print (~3 hours)
```

### 2. Position Camera
- Mount ESP32-CAM 10-15cm from meter face
- Perpendicular angle
- Ensure all digits visible
- Avoid reflections on meter glass

### 3. Power Connection
```
Wall Outlet → USB-C Charger → USB-C Cable → ESP32-CAM
```

---

## Training (Most Important!)

### Step 1: Define ROIs (Regions of Interest)
1. Web interface → "Reference Image"
2. Take clear photo of meter
3. Draw boxes around each digit (left to right)
4. Name: `digit1`, `digit2`, `digit3`, etc.
5. Set decimal point position
6. Save configuration

### Step 2: Collect Training Data
- Enable "Auto-Capture" mode
- Device photographs meter every 5 minutes
- Collect 100-200 images over 24-48 hours
- Captures different lighting conditions

### Step 3: Label Images
1. Go to "Train Neural Network"
2. Review first 20-30 images
3. Verify or correct digit recognition
4. Click ✓ if correct, type correct digit if wrong

### Step 4: Train Model
1. Click "Train" button
2. Training on device: ~10-30 minutes
3. Monitor logs for progress
4. **Target: >95% accuracy**

### Step 5: Deploy
- Check "Reading" tab for live results
- Compare with actual meter reading
- If <95%: label more images and retrain

---

## Home Assistant Integration

### Option A: MQTT (Recommended)

**1. Install Mosquitto Broker**
```
Settings → Add-ons → Add-on Store
Search: "Mosquitto broker"
Install → Start → Enable "Start on boot"
```

**2. Configure MQTT in AI-on-the-Edge**
```
Device web interface → Configuration → MQTT
Enable MQTT: ✓
Server: 192.168.178.2
Port: 1883
Topic: watermeter
Username: (optional)
Password: (optional)
Save
```

**3. Verify in Home Assistant**
```
Settings → Devices & Services
Should auto-discover: sensor.watermeter_value
```

### Option B: REST API

Add to `configuration.yaml`:
```yaml
sensor:
  - platform: rest
    name: Water Meter Reading
    resource: http://[device-ip]/json
    value_template: "{{ value_json.value }}"
    unit_of_measurement: "m³"
    scan_interval: 300  # 5 minutes
```

Restart Home Assistant

---

## Automations

### Daily Usage Notification
```yaml
alias: "Water usage alert"
trigger:
  - platform: time
    at: "23:00:00"
action:
  - service: notify.mobile_app
    data:
      title: "Daily Water Usage"
      message: >
        Today: {{ states('sensor.water_daily_usage') }} m³
        Current: {{ states('sensor.watermeter_value') }} m³
```

### Leak Detection
```yaml
alias: "Possible water leak"
trigger:
  - platform: numeric_state
    entity_id: sensor.watermeter_rate
    above: 10  # L/min
    for:
      hours: 2
condition:
  - condition: time
    after: "22:00:00"
    before: "06:00:00"
action:
  - service: notify.mobile_app
    data:
      title: "⚠️ Possible Leak!"
      message: "Water running for 2+ hours at night"
      data:
        priority: high
```

---

## Energy Dashboard

```
Settings → Energy → Configure
Water Consumption → Add water source
Select: sensor.watermeter_value
Save
```

HA automatically calculates daily/weekly usage!

---

## Troubleshooting

### Low Accuracy (<90%)
- Label more images (need 50-100 minimum)
- Check ROI boxes align perfectly with digits
- Ensure all digits visible in frame
- Retrain with varied lighting conditions

### Image Too Dark
- Enable flash LED in settings
- Add external LED illumination
- Increase camera brightness setting

### Device Offline
- Check power supply (5V/1A minimum)
- Verify WiFi connection (2.4GHz only!)
- Check MQTT broker running in HA

### Wrong Readings
- Check for reflections/shadows
- Verify decimal point position
- Ensure digits don't overlap ROI boundaries
- Add training images during problematic times

---

## Maintenance

**Weekly:**
- Spot check reading vs actual meter
- Verify device online

**Monthly:**
- Clean camera lens
- Clean meter glass
- Check mount stability

**As Needed:**
- Retrain if accuracy drops
- Update firmware (every 6 months)

---

## Resources

- **AI-on-the-Edge GitHub:** https://github.com/jomjol/AI-on-the-edge-device
- **Documentation:** https://jomjol.github.io/AI-on-the-edge-device/
- **Forum:** https://github.com/jomjol/AI-on-the-edge-device/discussions
- **3D Mount Design:** `../3d-models/watermeter-mount.scad`
- **Main Project Plan:** `PLAN.md` (Phase 3)

---

## Success Criteria

- [ ] ESP32-CAM ordered and received
- [ ] Firmware flashed successfully
- [ ] Device connected to WiFi
- [ ] Web interface accessible
- [ ] 3D mount printed and installed
- [ ] Camera positioned with clear view of all digits
- [ ] 100+ training images collected
- [ ] Model trained with >95% accuracy
- [ ] MQTT working in Home Assistant
- [ ] Reading appears: `sensor.watermeter_value`
- [ ] Energy Dashboard tracking water usage
- [ ] Daily usage automation working
- [ ] Leak detection automation active

**Status: Complete when all boxes checked!** ✅

---

## Notes

- First 24 hours: expect some errors as model learns
- Most errors are ±1 digit (minor, not critical)
- Accuracy improves over time with more training data
- Device runs autonomously - no maintenance needed
- Much cheaper than commercial solutions + great learning project!

**Last Updated:** 2026-02-22
