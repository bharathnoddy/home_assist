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
| District Heating (Vattenfall) | ⏸️ Deferred | Awaiting automatic reading support |

## Architecture

```
                    ┌─────────────────┐
                    │  Home Assistant │
                    │ (Raspberry Pi 5)│
                    │  192.168.178.2  │
                    └────────┬────────┘
                             │
        ┌────────────────────┼─────────────────────┐
        │                    │                      │
   ┌────▼────┐         ┌─────▼─────┐         ┌─────▼─────┐
   │  Ring   │         │   Shelly  │         │  Energy   │
   │Doorbell │         │  Relays   │         │Monitoring │
   │  (x2)   │         │  (WiFi)   │         └─────┬─────┘
   └─────────┘         └─────┬─────┘               │
                             │           ┌─────────┼──────────┐
                    ┌────────┴────────┐  │         │          │
                    │  Lights Behind  │  │         │          │
                    │  Wall Switches  │  │         │          │
                    │  (12-15 rooms)  │  │         │          │
                    └─────────────────┘  │         │          │
                                    ┌────▼───┐ ┌───▼────┐ ┌───▼────┐
                                    │P1 Meter│ │ Solax  │ │ESP32CAM│
                                    │HomeWiz │ │ Solar  │ │ Water  │
                                    │ (WiFi) │ │  API   │ │ Meter  │
                                    └────────┘ └────────┘ └────────┘

Future (Phase 5):
├─ Shelly Motion sensors (bathrooms/hallways)
├─ Tailscale VPN (secure remote access)
└─ Wall-mounted tablet dashboard
```

**All WiFi-based - No Zigbee coordinator needed!**

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
- Presence detection
- Smart routines (morning, evening, away)
- Security automations (Ring motion → lights)
- Energy optimization

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

**Other Future Ideas:**
- Wall-mounted tablet dashboard
- Climate control (smart thermostat)
- District heating (when Vattenfall enables auto-reading)
- Smart blinds/curtains

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

**Phase 5 - Remote Access:**
- [Tailscale VPN](https://tailscale.com/)

## License

This project is for personal use.
