# Phase 1: Home Assistant Installation Guide

## Prerequisites
- Raspberry Pi 5 (4GB+) ✓
- SD Card (32GB+ recommended) ✓
- Power supply (USB-C, **5V/5A** - Pi 5 requires more power than Pi 4!)
- Ethernet cable (recommended for initial setup)
- Computer with SD card reader

> **Note:** Pi 5 requires a 27W (5V/5A) power supply for full performance. Using a lower-rated supply may cause throttling or instability.

---

## Step 1: Download & Flash Home Assistant OS

### Option A: Using Raspberry Pi Imager (Recommended)

1. **Download Raspberry Pi Imager**
   - https://www.raspberrypi.com/software/

2. **Flash Home Assistant OS**
   ```
   1. Insert SD card into your computer
   2. Open Raspberry Pi Imager
   3. Click "Choose OS"
   4. Scroll down → "Other specific-purpose OS"
   5. Select "Home assistants and home automation"
   6. Select "Home Assistant" → "Home Assistant OS (RPi 5)"
   7. Click "Choose Storage" → Select your SD card
   8. Click "Write" (this will take 5-10 minutes)
   ```

### Option B: Manual Download

1. Download image: https://www.home-assistant.io/installation/raspberrypi
   - Select: **Home Assistant OS for Pi 5 (64-bit)**
   - File: `haos_rpi5-64-XX.X.img.xz`

2. Flash using [balenaEtcher](https://etcher.balena.io/):
   - Select downloaded image
   - Select SD card
   - Click Flash

---

## Step 2: First Boot

1. **Insert SD card** into Raspberry Pi 4
2. **Connect Ethernet cable** (recommended for first setup)
3. **Connect power** - the Pi will boot

4. **Wait ~20 minutes** for initial setup
   - Home Assistant downloads and installs components
   - The green LED will flicker during activity

---

## Step 3: Access Home Assistant

### Find Your Pi's IP Address

**Option A: Use homeassistant.local**
- Open browser: http://homeassistant.local:8123

**Option B: Find IP via Router**
- Log into your router admin page
- Look for device named "homeassistant"
- Note the IP address (e.g., 192.168.1.100)
- Access: http://192.168.1.XXX:8123

**Option C: Use Network Scanner**
- Install "Fing" app on your phone
- Scan network for new devices

---

## Step 4: Initial Configuration

1. **Create Account**
   - Name: Your name
   - Username: (your choice)
   - Password: (strong password - you'll need this!)

2. **Set Location**
   - Enter your home address or coordinates
   - This enables location-based automations (sunset/sunrise)

3. **Select Time Zone**
   - Should auto-detect from location

4. **Opt-in/out of Analytics**
   - Your choice

5. **Review Discovered Devices**
   - HA may auto-discover some devices on your network
   - You can skip and add them later

---

## Step 5: Configure Static IP (Recommended)

### Via Home Assistant UI

1. Go to **Settings** → **System** → **Network**
2. Click on your network adapter (eth0 for ethernet)
3. Change from DHCP to Static
4. Enter:
   - IP: `192.168.1.XXX` (choose an IP outside your router's DHCP range)
   - Subnet: `255.255.255.0`
   - Gateway: `192.168.1.1` (your router IP)
   - DNS: `8.8.8.8` or your router IP

### Via Router (Alternative)
- Log into router
- Find DHCP reservation / static lease
- Assign fixed IP to Home Assistant's MAC address

---

## Step 6: Install HACS (Home Assistant Community Store)

HACS is needed for custom integrations like Solax Modbus.

### Installation Steps

1. **Open Terminal in HA**
   - Settings → Add-ons → Add-on Store
   - Search "Terminal & SSH"
   - Install → Start → Enable "Show in sidebar"

2. **Run HACS Install Script**
   - Open Terminal from sidebar
   - Run:
   ```bash
   wget -O - https://get.hacs.xyz | bash -
   ```

3. **Restart Home Assistant**
   - Settings → System → Restart

4. **Add HACS Integration**
   - Settings → Devices & Services → Add Integration
   - Search "HACS" → Follow GitHub authorization

---

## Verification Checklist

After completing Phase 1 setup:

- [ ] Home Assistant accessible at http://homeassistant.local:8123
- [ ] User account created and can log in
- [ ] Location and timezone configured
- [ ] Static IP assigned (note it down: _______________)
- [ ] HACS installed and visible in sidebar

---

## Troubleshooting

### Can't access homeassistant.local
- Wait longer (initial boot takes 15-20 min)
- Try IP address directly
- Ensure Pi and computer are on same network
- Check Pi has power (red LED) and activity (green LED)

### Slow performance
- Consider upgrading to SSD later (Pi 5 has native NVMe support!)
- **Check power supply is 5A/27W capable** (Pi 5 requirement)
- Look for lightning bolt icon in HA - indicates under-voltage

### Lost password
- You'll need to reset via command line
- See: https://www.home-assistant.io/docs/locked_out/

---

## Next Steps

Once basic setup is complete:
1. [Add Ring Integration](./phase1-ring.md)
2. [Add Alexa Integration](./phase1-alexa.md)
3. [Set up Remote Access](./phase1-remote-access.md)
