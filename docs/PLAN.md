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

## Phase 3: Smart Lighting (Weekend 5-7)
**Goal:** Smart lights on all 3 floors controlled via HA and Alexa

### Tasks
1. **Hardware Planning**
   - [ ] Count fixtures per floor
   - [ ] Decide: bulbs vs. smart switches vs. combination
   - [ ] Purchase IKEA Tradfri gateway + bulbs OR Zigbee coordinator

2. **Zigbee Setup (Recommended Approach)**
   - Option A: Use IKEA Tradfri Gateway (simpler)
   - Option B: Use Zigbee coordinator (ConBee II / Sonoff Zigbee 3.0) for direct control (more flexible, recommended for advanced users)

3. **Installation**
   - [ ] Install coordinator/gateway
   - [ ] Pair bulbs floor by floor
   - [ ] Create rooms/zones in HA
   - [ ] Expose to Alexa for voice control

4. **Basic Automations**
   - [ ] Lights on at sunset
   - [ ] Lights off when leaving home
   - [ ] Motion-activated lights (requires motion sensors)

### Deliverables
- All lights controllable via HA dashboard, Alexa voice, and mobile app
- Basic lighting automations working

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

### Phase 2-3: Zigbee + Lighting (~EUR 200-350 total)
| Item | Purpose | Est. Cost |
|------|---------|-----------|
| **Sonoff ZBDongle-E** | Zigbee coordinator (better range than P) | EUR 15-20 |
| IKEA Tradfri E27 bulbs (x10-15) | Main room lighting | EUR 10-12 each |
| IKEA Tradfri GU10 bulbs (x5-10) | Spotlights (if needed) | EUR 8-10 each |
| IKEA Tradfri remote | Physical control backup | EUR 8 |

### Phase 4: Automation Enhancers
| Item | Purpose | Est. Cost |
|------|---------|-----------|
| IKEA Tradfri motion sensor (x3) | One per floor for auto-lights | EUR 10 each |
| Aqara door/window sensor (x2) | Entry detection | EUR 12 each |
| Smart plug Zigbee (x2-3) | Appliance monitoring | EUR 15 each |

### Optional Services
| Item | Purpose | Est. Cost |
|------|---------|-----------|
| Nabu Casa subscription | Easy remote access + Alexa cloud link | EUR 6.50/month |
| DuckDNS + Let's Encrypt | Free alternative for remote access | Free |

### Estimated Total: EUR 250-400 (excluding Pi)

---

## Technical Architecture

```
                    +------------------+
                    |     Alexa        |
                    |  (Voice Control) |
                    +--------+---------+
                             |
                    +--------v---------+
                    |  Home Assistant  |
                    |  (Raspberry Pi)  |
                    +--------+---------+
                             |
        +--------------------+--------------------+
        |                    |                    |
   +----v----+         +-----v-----+        +----v----+
   |  Ring   |         |  Zigbee   |        | Energy  |
   |Doorbell |         |  Network  |        | Monitor |
   +---------+         +-----+-----+        +----+----+
                             |                   |
                    +--------+--------+    +-----+-----+
                    |  Smart Lights   |    | P1 Meter  |
                    |  (All Floors)   |    | + Solar   |
                    +-----------------+    +-----------+
```

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
