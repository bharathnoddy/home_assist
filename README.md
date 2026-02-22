# Home Automation Project

Central smart home system using **Home Assistant** on Raspberry Pi, integrating existing devices and adding smart lighting across 3 floors.

## Current Setup

| Device | Status | Integration |
|--------|--------|-------------|
| Raspberry Pi 5 | ✅ Running | Home Assistant OS @ 192.168.178.2 |
| Ring Doorbells (x2) | ✅ Connected | Front + back door with motion & camera |
| P1 Meter (HomeWizard) | ✅ Connected | Real-time electricity monitoring |
| Solax Solar Inverter | ✅ Connected | Production monitoring via SolaxCloud API |
| Energy Dashboard | ✅ Active | Import/export tracking |
| Smart Lights (Shelly Relays) | 🔲 Planned | Phase 3 - WiFi relays behind switches |
| Water Meter (DIY ESP32-CAM) | 🔲 Planned | Phase 3 - AI-on-the-Edge OCR reader |
| Motion Sensors (Shelly Motion) | 🔲 Future | Phase 5 - Bathrooms & hallways |
| Remote Access (VPN) | 🔲 Future | Phase 5 - Tailscale secure tunnel |
| District Heating (Vattenfall) | ⏸️ Future | Via smart gateway when P1 port enabled |
| Ecovacs Deebot Vacuum | ✅ Connected | Robot vacuum control & monitoring |

## Architecture

```
                         ┌──────────────────────┐
                         │   Home Assistant     │
                         │   (Raspberry Pi 5)   │
                         │    192.168.178.2     │
                         └──────────┬───────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┬──────────────┐
        │                           │                           │              │
   ┌────▼─────┐              ┌──────▼──────┐           ┌───────▼───────┐  ┌──▼────────┐
   │  Ring    │              │   Shelly    │           │    Energy     │  │  Ecovacs  │
   │Doorbell  │              │   Relays    │           │  Monitoring   │  │   Deebot  │
   │  (x2)    │              │   (WiFi)    │           │   Dashboard   │  │  (Cloud)  │
   └──────────┘              └──────┬──────┘           └───────┬───────┘  └───────────┘
                                    │                          │
                          ┌─────────┴─────────┐      ┌─────────┼─────────┬─────────┬──────────┐
                          │  Lights Behind    │      │         │         │         │          │
                          │  Wall Switches    │      │         │         │         │          │
                          │  (12-15 rooms)    │      │         │         │         │          │
                          └───────────────────┘      │         │         │         │          │
                                                ┌────▼────┐ ┌──▼────┐ ┌──▼─────┐ ┌─▼────────┐
                                                │P1 Meter │ │ Solax │ │ESP32CAM│ │ District │
                                                │HomeWiz  │ │ Solar │ │ Water  │ │ Heating  │
                                                │Electric │ │ (API) │ │ Meter  │ │Vattenfall│
                                                │ (WiFi)  │ │       │ │ (WiFi) │ │ (Future) │
                                                └─────────┘ └───────┘ └────────┘ └─────┬────┘
                                                                                        │
                                                                               Via P1 gateway
                                                                               when enabled

┌─── Future Additions (Phase 5) ───────────────────────────────────────────┐
│  • Shelly Motion sensors (bathrooms/hallways) - WiFi                     │
│  • Tailscale VPN (secure remote access) - FREE                           │
│  • District Heating via smart gateway (waiting for Vattenfall P1 port)   │
│  • Wall-mounted tablet dashboard                                         │
└───────────────────────────────────────────────────────────────────────────┘
```

**✅ All WiFi-based - No Zigbee coordinator needed!**
**✅ No monthly subscriptions required**

## Project Progress

### ✅ Phase 1: Foundation (Complete)
- Home Assistant OS on Raspberry Pi 5
- Ring doorbell integration (front + back)
- HACS installed
- Basic dashboard setup

### ✅ Phase 2: Energy Monitoring (Complete)
- P1 meter (HomeWizard) integration
- Solax solar monitoring
- Energy Dashboard configured
- Real-time import/export tracking

### 🔲 Phase 3: Smart Lighting + Water Monitoring (In Progress)

**Part A: Shelly Smart Lighting**
- Shelly relays behind existing wall switches (12-15 units)
- Normal LED bulbs (cheaper than smart bulbs)
- Physical switches continue to work normally
- App control for remote on/off
- Basic lighting automations

**Part B: DIY Water Meter Reader**
- ESP32-CAM with AI-on-the-Edge firmware
- Automatically reads analog water meter via OCR
- 95%+ accuracy after training
- Cost: €22-32 vs €50 HomeWizard = €18-28 savings
- 3D printed camera mount
- MQTT integration to Home Assistant
- See: [Water Meter Setup Guide](docs/water-meter-setup.md)

**Why Shelly + DIY approach:**
- All WiFi-based (no Zigbee coordinator needed)
- Family-friendly (switches work as before)
- Cost-effective (saves ~€100 total)
- Great learning experience

### 🔲 Phase 4: Advanced Automations (Planned)
- Presence detection (phone-based via HA Companion app)
- Smart routines (morning, evening, away, guest mode)
- Security automations (Ring motion → lights, late night alerts)
- Energy optimization (solar peak usage)
- Vacuum automations (Ecovacs Deebot scheduling, auto-clean when away)

### 🔲 Phase 5: Future Enhancements

**Motion Sensors (Bathrooms & Hallways)**
- Shelly Motion sensors (WiFi, battery-powered)
- Auto-on lights when motion detected
- Auto-off after timeout
- Night mode (dim or off during sleep hours)
- Cost: ~€45-72 for 3-4 sensors

**Secure Remote Access**
- Tailscale VPN (FREE, WireGuard-based)
- Access HA from anywhere securely
- No port forwarding needed
- Works behind NAT/firewall

**District Heating Monitoring**
- Vattenfall Warmtelink vI1 meter (currently installed)
- Waiting for Vattenfall to enable P1 port
- When available: Use smart gateway for automatic reading
- Options when enabled:
  - HomeWizard P1 gateway (if compatible)
  - Direct DSMR integration via RJ-12 port
  - Integrate with Energy Dashboard
  - Track heating usage and costs

**Other Future Ideas:**
- Wall-mounted tablet dashboard
- Climate control (smart thermostat)
- Smart blinds/curtains
- Garden irrigation automation

## Documentation

- [Detailed Implementation Plan](docs/PLAN.md) - Complete 5-phase roadmap
- [Phase 1 & 2 Completion Report](docs/PHASE1-2-COMPLETE.md)
- [Phase 3: Shelly Lighting Guide](docs/phase3-lighting-revised.md)
- [Phase 3: Water Meter Setup](docs/water-meter-setup.md) - DIY ESP32-CAM project
- [Hardware Shopping List](docs/PLAN.md#hardware-shopping-list)
- [3D Models](3d-models/) - OpenSCAD designs for 3D printing

## Hardware Budget

| Phase | Components | Est. Cost |
|-------|-----------|-----------|
| Phase 1-2 | ✅ Complete | - |
| Phase 3A | Shelly relays + bulbs | €180-250 |
| Phase 3B | DIY water meter | €22-32 |
| Phase 5 | Motion sensors + VPN | €45-72 (VPN free) |
| **Total** | **Phases 3-5** | **€247-354** |

**All-in (excluding Pi 5): €247-354** - Much cheaper than originally planned!

## Quick Links

**Home Assistant:**
- [Home Assistant](https://www.home-assistant.io/)
- [HACS (Home Assistant Community Store)](https://hacs.xyz/)

**Phase 3 - Smart Lighting:**
- [Shelly Official Site](https://www.shelly.cloud/)
- [Shelly Home Assistant Integration](https://www.home-assistant.io/integrations/shelly/)

**Phase 3 - Water Meter:**
- [AI-on-the-Edge-Device](https://github.com/jomjol/AI-on-the-edge-device)
- [ESP32-CAM Setup Guide](https://jomjol.github.io/AI-on-the-edge-device/)
- [OpenSCAD (3D Design)](https://openscad.org/)

**Energy Monitoring:**
- [HomeWizard P1 Meter](https://www.home-assistant.io/integrations/homewizard/)
- [SolaxCloud Integration](https://www.home-assistant.io/integrations/solax/)

**Smart Devices:**
- [Ecovacs Deebot (via HACS)](https://github.com/And3rsL/Deebot-4-Home-Assistant)
- [Ring Doorbell Integration](https://www.home-assistant.io/integrations/ring/)

**Phase 5 - Remote Access:**
- [Tailscale VPN](https://tailscale.com/)

## License

This project is for personal use.
