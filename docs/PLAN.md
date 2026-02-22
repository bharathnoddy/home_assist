# Home Automation Project Plan

## Overview
Central smart home system using **Home Assistant** on Raspberry Pi, integrating existing devices (Alexa, Ring, Solar, P1 meter) and adding smart lighting across 3 floors.

---

## Current Setup
- Alexa (voice control)
- Ring doorbells x2 (front + back door, connected to Alexa)
- Raspberry Pi 5 (available)
- **Solax solar inverter** (installed by Mobisolar, monitoring via SolaxCloud app)
- **P1 meter** with direct cable connection (DSMR compatible)
- Smart lights (planned - IKEA Tradfri, ~10-20 bulbs across 3 floors)

---

## Phase 1: Foundation (Weekend 1-2)
**Goal:** Get Home Assistant running with basic integrations

### Tasks
1. **Install Home Assistant OS on Raspberry Pi**
   - Flash Home Assistant OS to SD card (or SSD for better performance)
   - Initial setup wizard
   - Configure network settings

2. **Basic Integrations**
   - [ ] Alexa integration (via Home Assistant Cloud or manual skill)
   - [ ] Ring doorbell integration (native HA integration)
   - [ ] Set up mobile app for remote access

3. **Network Setup**
   - Configure static IP for Pi
   - Optional: Set up HTTPS with DuckDNS or Nabu Casa subscription

### Deliverables
- Home Assistant dashboard accessible locally and remotely
- Ring doorbell visible in HA with live feed
- Alexa can control HA entities

---

## Phase 2: Energy Monitoring (Weekend 3-4)
**Goal:** Unified energy dashboard combining solar + grid consumption

### Tasks
1. **P1 Meter Integration (DSMR)**
   - [ ] Connect P1 cable to Raspberry Pi via USB-to-serial adapter
   - [ ] Install DSMR Slimme Meter integration (native HA support)
   - [ ] Configure `/dev/ttyUSB0` serial port in HA
   - [ ] Verify real-time consumption data appears

2. **Solax Solar Integration**
   - [ ] Install "Solax Modbus" integration via HACS (local polling, recommended)
   - [ ] Alternative: Use SolaxCloud integration (cloud-based, easier but slower)
   - [ ] Configure inverter IP address for local Modbus connection
   - [ ] Add solar production to energy dashboard

3. **Energy Dashboard**
   - [ ] Configure HA Energy Dashboard
   - [ ] Set up daily/monthly consumption tracking
   - [ ] Create automations for high-usage alerts

### Deliverables
- Single dashboard showing: grid consumption, solar production, net usage
- Historical data and trends
- Cost tracking (configure energy prices)

---

## Phase 3: Smart Lighting + Water Monitoring (Weekend 5-7) - REVISED
**Goal:** Smart control while keeping physical switches working (80% switch / 20% app usage) + DIY water meter reader

**Strategy Change:** Using **Shelly relays + normal bulbs** instead of smart bulbs
**NEW:** Building **DIY water meter reader** with ESP32-CAM (in parallel with Shelly installation)

### Why This Approach
- Physical switches continue working normally (family-friendly)
- App control for remote on/off (turn off forgotten lights)
- Much cheaper (normal LED bulbs €3-5 vs smart bulbs €10-15)
- More reliable (one relay per room vs WiFi per bulb)
- **Water monitoring:** DIY solution (€25-35) vs HomeWizard (€50) = savings + learning

### Tasks - Part A: Shelly Lighting
1. **Check Prerequisites**
   - [ ] Check switch box depth (need 35mm+)
   - [ ] Verify neutral wire present (blue wire in switch box)
   - [ ] Count switch locations (not bulbs)
   - [ ] Assess electrical comfort level

2. **Test Installation**
   - [ ] Order 2x Shelly 1 for testing
   - [ ] Install in 1-2 high-usage rooms
   - [ ] Add Shelly integration to HA
   - [ ] Test switch + app control

3. **Full Rollout**
   - [ ] Order remaining Shelly units (8-10 more)
   - [ ] Install room by room
   - [ ] Create dashboard controls
   - [ ] Set up areas/zones in HA

4. **Basic Automations**
   - [ ] Auto-off forgotten lights (30 min timeout)
   - [ ] Turn off all lights when leaving home
   - [ ] Bedtime routine (turn off downstairs)

5. **Include Bathroom & Hallway Relays**
   - [ ] Install Shelly relays in bathrooms (2-3 rooms)
   - [ ] Install Shelly relays in hallways (1-2 locations)
   - [ ] Prepare for Phase 5 motion sensor integration
   - [ ] Test switch functionality in wet environments

### Tasks - Part B: DIY Water Meter Reader (Parallel Work)

1. **Order Hardware**
   - [ ] ESP32-CAM with USB-C (~€15-20) - [Amazon link](https://www.amazon.nl/CAM-module-QIQIAZI-ESP-32-CAM-ontwikkelingskaart-TF-kaartmodule/dp/B0DKT9BDBD/)
   - [ ] 32GB microSD card (Class 10+) (~€7-12)
   - [ ] Check at home: USB-C cable and power adapter

2. **3D Print Mount**
   - [ ] Download OpenSCAD (free software)
   - [ ] Measure water meter location (distance, mounting space)
   - [ ] Customize mount design (adjust camera_distance parameter)
   - [ ] Print mount (~3 hours print time)

3. **Setup ESP32-CAM**
   - [ ] Format SD card to FAT32
   - [ ] Flash AI-on-the-Edge firmware via USB-C
   - [ ] Configure WiFi connection
   - [ ] Install MQTT broker in Home Assistant (if not already)

4. **Install and Train**
   - [ ] Mount ESP32-CAM near water meter
   - [ ] Position camera with clear view of all digits
   - [ ] Define ROI (Region of Interest) boxes around digits
   - [ ] Collect 100-200 training images (automatic, 24 hours)
   - [ ] Label first 20-30 images manually
   - [ ] Train neural network (>95% accuracy target)

5. **Home Assistant Integration**
   - [ ] Configure MQTT in AI-on-the-Edge device
   - [ ] Verify sensor appears in HA (sensor.watermeter_value)
   - [ ] Add to Energy Dashboard
   - [ ] Create daily usage automation
   - [ ] Create leak detection automation

### Deliverables
**Lighting:**
- All lights controllable via physical switch (normal usage)
- All lights controllable via HA app (remote control)
- At least 2 automations working (auto-off, leaving home)
- Family doesn't notice any change (switches work as before)

**Water Monitoring:**
- Automatic water meter reading every 5 minutes
- 95%+ OCR accuracy
- Water usage tracked in Energy Dashboard
- Leak detection automation active
- Daily usage notifications

---

## Phase 4: Advanced Automations (Weekend 8-10)
**Goal:** Intelligent home that reacts to context

### Tasks
1. **Presence Detection**
   - [ ] Phone-based presence (HA Companion app)
   - [ ] Router-based device tracking (optional)
   - [ ] Create home/away modes

2. **Smart Routines**
   - [ ] Morning routine (gradual lights, briefing)
   - [ ] Evening routine (dim lights, close blinds if applicable)
   - [ ] Away mode (random lights for security)
   - [ ] Guest mode

3. **Energy Optimization**
   - [ ] Shift high-consumption appliances to solar peak hours
   - [ ] Alerts when solar production exceeds consumption
   - [ ] Smart plug monitoring for specific appliances

4. **Security Automations**
   - [ ] Front Ring motion -> turn on front porch lights
   - [ ] Back Ring motion -> turn on back garden lights
   - [ ] Any doorbell pressed -> notification + snapshot to phone
   - [ ] Late night motion (either door) -> security alert + all exterior lights on
   - [ ] Away mode -> Ring motion triggers interior lights (simulate presence)

### Deliverables
- Context-aware home automations
- Energy-optimized scheduling
- Enhanced security routines

---

## Phase 5: Enhancements (Future)
**Ideas for expansion:**

### Motion Sensors (Bathrooms & Hallways)
**Goal:** Automatic lights in bathrooms and hallways using WiFi motion sensors + Shelly relays

**Hardware Needed:**
- Motion sensors: **Shelly Motion** (WiFi, battery-powered)
- Locations: 2-3 bathrooms, 1-2 hallways
- **Note:** Shelly relays already installed in Phase 3!

**Why Shelly Motion:**
- ✅ WiFi (no Zigbee coordinator needed)
- ✅ Works directly with Home Assistant
- ✅ Battery powered (1-year battery life)
- ✅ Integrates seamlessly with Shelly ecosystem
- ✅ Adjustable sensitivity and timeout

**Automations:**
- [ ] Bathroom lights auto-on when motion detected
- [ ] Auto-off after 5-10 minutes no motion
- [ ] Night mode: keep lights off or very dim (via Shelly Dimmer if installed)
- [ ] Hallway lights: on when passing through, off after 2 minutes
- [ ] Adjust sensitivity to avoid false triggers

**Integration:**
- All WiFi (no Zigbee needed!)
- Use Shelly relays already in place (Phase 3)
- Shelly Motion → triggers automation → Shelly relay ON/OFF
- Create custom automations per bathroom/hallway
- Dashboard toggle for enabling/disabling auto-lights

**Shopping List:**
| Item | Quantity | Purpose | Est. Cost |
|------|----------|---------|-----------|
| **Shelly Motion** | 3-4 | Bathrooms + hallways motion detection | €15-18 each |
| **Shelly Dimmer 2** (optional) | 1-2 | For night mode dimming in bathrooms | €22 each |
| **Total (Motion only)** | | | **€45-72** |
| **Total (with dimmers)** | | | **€89-116** |

### Water Monitoring
- ~~**HomeWizard Water Meter** (~EUR 50)~~ → **MOVED TO PHASE 3** (DIY ESP32-CAM solution)
- ✅ **Complete in Phase 3** with AI-on-the-Edge-Device
- Saves €18-28 compared to HomeWizard
- Already integrated with Energy Dashboard

### District Heating Automation
**Current Status:** Vattenfall Warmtelink vI1 meter installed (manual reading only)

**Future Plan (When P1 Port Enabled):**
- **Primary Option:** Smart gateway with P1 port integration
  - HomeWizard P1 gateway (if compatible with heating meter)
  - Direct DSMR integration via RJ-12 to P1 adapter
  - Automatic reading every 5-10 seconds

**Integration Options:**
1. **Via P1 Port (when Vattenfall enables it):**
   - Connect smart gateway to RJ-12 port
   - Use DSMR integration in Home Assistant
   - Real-time heating consumption data

2. **Via Vattenfall Portal Scraper (backup):**
   - Web scraping integration (community custom component)
   - Monthly/daily data only (not real-time)
   - Less reliable, requires portal access

**When Available:**
- [ ] Check if Vattenfall enabled P1 port functionality
- [ ] Order compatible smart gateway (HomeWizard or similar)
- [ ] Connect to RJ-12 port on Warmtelink vI1 meter
- [ ] Add to Home Assistant Energy Dashboard
- [ ] Track heating costs and usage trends
- [ ] Create automations (high usage alerts, monthly reports)

**Expected Integration:**
- Sensor: `sensor.district_heating_power` (kW)
- Sensor: `sensor.district_heating_energy` (GJ or MWh)
- Energy Dashboard: Heating consumption tracking
- Cost tracking with Vattenfall tariff rates

**Note:** Monitor Vattenfall announcements for P1 port availability

### Climate Control
- Smart thermostat (tado, Nest, or Zigbee TRVs)
- Per-room temperature control
- Heating based on solar availability

### Security
- Door/window sensors (Zigbee)
- Indoor cameras
- Alarm system integration

### Convenience
- Smart blinds/curtains
- Smart locks
- Media room control (TV, speakers)
- Vacuum robot integration

### Secure Remote Access (VPN Tunnel)
**Goal:** Access Home Assistant securely from anywhere without exposing it to the internet

**Options:**

**Option 1: Tailscale (Recommended - Easiest)**
- ✅ Free for personal use
- ✅ Zero-config VPN (WireGuard-based)
- ✅ Works behind NAT/firewall
- ✅ Cross-platform (iOS, Android, Windows, Mac, Linux)
- ✅ No port forwarding needed
- Install Tailscale on Pi and your devices
- Access HA: http://100.x.x.x:8123 (Tailscale IP)

**Option 2: WireGuard VPN Server**
- Install WireGuard on Raspberry Pi
- Configure clients (phone, laptop)
- Port forward UDP port (51820)
- More control but requires manual setup

**Option 3: CloudFlare Tunnel (Advanced)**
- Free secure tunnel to HA
- No port forwarding
- Access via subdomain
- Requires CloudFlare account

**Option 4: Nabu Casa (Paid)**
- Official Home Assistant Cloud
- €6.50/month
- Also enables Alexa/Google Home
- Easiest but costs money

**Recommended: Tailscale**
```bash
# On Raspberry Pi
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

# On phone/laptop: Install Tailscale app
# Access HA via Tailscale IP
```

**Shopping List:**
| Item | Purpose | Est. Cost |
|------|---------|-----------|
| Tailscale account | Free VPN mesh network | FREE |
| OR Nabu Casa subscription | Official HA Cloud | €6.50/month |

### Wall-Mounted Tablet Dashboard
- **Hardware options:**
  - Amazon Fire tablet (cheap, EUR 50-80, works great)
  - Samsung Galaxy Tab A (better quality, EUR 150+)
  - Old iPad/Android tablet (reuse what you have)
- **Software:**
  - Fully Kiosk Browser app (best for always-on kiosk mode)
  - Screen dims at night, wakes on motion (use tablet camera)
  - Auto-launches HA dashboard on boot
- **Mounting:**
  - Wall mount bracket (EUR 15-30)
  - USB power routed through wall (or visible cable)
  - Consider location: hallway, kitchen, living room entrance
- **Dashboard design:**
  - Custom Lovelace layout optimized for tablet size
  - Floor plan view with device status
  - Quick controls: lights, climate, scenes
  - Ring doorbell live feeds
  - Weather + energy display

---

## Hardware Shopping List

### Phase 1: Foundation
| Item | Purpose | Est. Cost |
|------|---------|-----------|
| Raspberry Pi 5 (4GB+) | Already have | - |
| 27W USB-C Power Supply | Pi 5 requires 5V/5A | Check if you have one |
| NVMe SSD + HAT (optional) | Pi 5 has native NVMe support! | EUR 40-60 |
| USB-to-serial adapter (FTDI) | P1 meter connection | EUR 10-15 |

### Phase 3A: Shelly Smart Lighting (~EUR 180-250 total)
| Item | Purpose | Est. Cost |
|------|---------|-----------|
| **Shelly 1** (x12-15) | Smart relay behind switches (all rooms including bathrooms/hallways) | EUR 10-12 each |
| **Shelly Plus 1 PM Mini** (x2-3) | For tight spaces (if needed) | EUR 15 each |
| Normal LED bulbs (x15-20) | Actual light sources | EUR 3-5 each |

### Phase 3B: DIY Water Meter Reader (~EUR 25-35 total)
| Item | Purpose | Est. Cost |
|------|---------|-----------|
| **ESP32-CAM with USB-C** | Camera + WiFi + AI-on-the-Edge | EUR 15-20 |
| **32GB microSD card** | Firmware + training images | EUR 7-12 |
| USB-C cable | Programming + power | Check at home |
| USB-C power adapter | Permanent power | Check at home |
| 3D printer filament (PLA) | Camera mount (~30g) | EUR 1-2 |

### Phase 4: Automation Enhancers
| Item | Purpose | Est. Cost |
|------|---------|-----------|
| Aqara door/window sensor (x2) | Entry detection | EUR 12 each |
| Smart plug Zigbee (x2-3) | Appliance monitoring | EUR 15 each |

### Phase 5: Motion Sensors (Bathrooms & Hallways)
| Item | Purpose | Est. Cost |
|------|---------|-----------|
| **Shelly Motion** (x3-4) | WiFi motion sensors for bathrooms + hallways | EUR 15-18 each |
| **Shelly Dimmer 2** (optional, x1-2) | For night mode dimming capability | EUR 22 each |

### Optional Services
| Item | Purpose | Est. Cost |
|------|---------|-----------|
| Nabu Casa subscription | Easy remote access + Alexa cloud link | EUR 6.50/month |
| DuckDNS + Let's Encrypt | Free alternative for remote access | Free |

### Estimated Total: EUR 250-400 (excluding Pi)

---

## Technical Architecture (Updated for Shelly + ESP32-CAM)

```
                         +------------------+
                         |  Home Assistant  |
                         | (Raspberry Pi 5) |
                         |  192.168.178.2   |
                         +--------+---------+
                                  |
         +------------------------+---------------------------+
         |                        |                           |
    +----v----+            +------v-------+            +------v------+
    |  Ring   |            |   Shelly     |            |   Energy    |
    |Doorbell |            |   Relays     |            |  Monitoring |
    | (x2)    |            | WiFi Direct  |            +------+------+
    +---------+            +------+-------+                   |
                                  |                           |
                         +--------+--------+        +---------+----------+
                         |                 |        |                    |
                    +----v-----+     +-----v----+   |                    |
                    |  Lights  |     | Zigbee   |   |                    |
                    | (Shelly  |     | (Motion  |   |                    |
                    | behind   |     | sensors, |   |                    |
                    | switches)|     | RGB kids)|   |                    |
                    +----------+     +----------+   |                    |
                                                +----v----+        +------v-------+
                                                | P1 Meter|        | ESP32-CAM    |
                                                | (HomeWiz|        | Water Meter  |
                                                |  -ard)  |        | AI-on-Edge   |
                                                +---------+        | (MQTT/WiFi)  |
                                                |                  +--------------+
                                          +-----v-----+
                                          |  Solax    |
                                          |  Solar    |
                                          | Inverter  |
                                          +-----------+
```

**Key Components:**
- **Shelly Relays**: Behind existing wall switches (WiFi, ~12-15 units including bathrooms/hallways)
- **Shelly Motion** (Phase 5): WiFi motion sensors for bathrooms/hallways
- **ESP32-CAM**: DIY water meter reader with AI-on-the-Edge (MQTT to HA)
- **P1 Meter**: HomeWizard WiFi (electricity import/export)
- **Solax**: Solar production monitoring via SolaxCloud API (cloud-based)
- **Ring**: 2x doorbells (front + back)

**Note:** All WiFi-based - NO Zigbee coordinator needed!

---

## Pre-Start Checklist

- [x] Solar inverter: **Solax** (use Solax Modbus integration)
- [x] P1 meter: **Direct cable** (use DSMR integration)
- [x] Light count: **10-20 bulbs** (single Zigbee coordinator sufficient)
- [ ] Count exact bulb types needed per room (E27, E14, GU10?)
- [ ] Verify Solax inverter has Modbus enabled / get local IP
- [ ] Check if P1 cable has RJ12 connector for Pi connection

---

## Success Criteria
- [ ] Single dashboard for all home controls
- [ ] Voice control via Alexa for all devices
- [ ] Unified energy view (solar + consumption)
- [ ] Automated lighting based on time/presence
- [ ] Remote access from anywhere
