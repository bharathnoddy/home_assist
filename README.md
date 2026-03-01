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
| Smart Lights (Smart Switches) | 🔄 In Progress | Phase 3 - WiFi smart switches (Shelly/Tuya) |
| Water Meter (DIY ESP32-CAM) | 🔄 In Progress | Phase 3 - Training in progress, MQTT working |
| Remote Access (Tailscale VPN) | ✅ Connected | Secure remote access configured |
| Motion Sensors | 🔲 Future | Phase 5 - Bathrooms & hallways |
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
   │  Ring    │              │   Smart     │           │    Energy     │  │  Ecovacs  │
   │Doorbell  │              │  Switches   │           │  Monitoring   │  │   Deebot  │
   │  (x2)    │              │Shelly/Tuya  │           │   Dashboard   │  │  (Cloud)  │
   └──────────┘              └──────┬──────┘           └───────┬───────┘  └───────────┘
                                    │                          │
                          ┌─────────┴─────────┐      ┌─────────┼─────────┬─────────┬──────────┐
                          │  WiFi Switches    │      │         │         │         │          │
                          │  Replace Existing │      │         │         │         │          │
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

### 🔄 Phase 3: Smart Lighting + Water Monitoring (In Progress)

**Part A: Smart Switch Lighting** ⏳
- **DECISION UPDATED:** Using WiFi smart switches instead of relays
- Replace existing switches with smart switches (12-15 units)
- Options considered:
  - Shelly Wall Switch (€22-28 each) - Premium, local control
  - Tuya Smart Switch (€12-18 each) - Budget-friendly
  - Sonoff MINI R4 (€13-18 each) - Behind existing switches
- **Why smart switches won vs Shelly relays:**
  - Much simpler installation (like replacing normal switch)
  - No WAGO connectors needed (beginner-friendly)
  - Future-proof (easy to replace/upgrade)
  - Only €5-10 more per switch (worth the simplicity!)
- Testing phase: Order 2-3 units first, then rollout
- See: [Smart Switch Decision Guide](docs/smart-switch-guide.md)

**Part B: DIY Water Meter Reader** 🔄
- ✅ ESP32-CAM with AI-on-the-Edge firmware installed
- ✅ MQTT integration working with Home Assistant
- ✅ Added to Energy Dashboard
- ✅ ApexCharts visualization configured
- 🔄 Auto-training in progress (24-48 hours for 90%+ accuracy)
- 🔄 Currently using test print, will move to real meter soon
- Cost: €22-32 vs €50 HomeWizard = €18-28 savings
- 3D printed camera mount designed
- See: [Water Meter Setup Guide](docs/water-meter-setup.md)

**Why WiFi Smart Switches + DIY approach:**
- All WiFi-based (no Zigbee coordinator needed)
- Beginner-friendly installation (smart switches = simple)
- Cost-effective (saves money on water meter)
- Great learning experience
- Future-proof and maintainable

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

| Phase | Components | Est. Cost | Status |
|-------|-----------|-----------|--------|
| Phase 1-2 | ✅ Complete | - | ✅ Done |
| Phase 3A | Smart switches (15 units) | €180-420 | 🔄 Testing |
| | - Tuya option (budget) | €180 (15 × €12) | Option A |
| | - Sonoff MINI option | €225 (15 × €15) | Option B |
| | - Shelly Wall Switch (premium) | €375 (15 × €25) | Option C |
| Phase 3B | DIY water meter | €22-32 | 🔄 Training |
| Phase 5 | Tailscale VPN | FREE | ✅ Done |
| Phase 5 | Motion sensors | €45-72 | 🔲 Future |
| **Total** | **Phases 3-5** | **€247-524** | |

**Budget-friendly option:** Tuya switches = €180 + €32 water meter = **€212 total**
**Premium option:** Shelly switches = €375 + €32 water meter = **€407 total**
**Recommended:** Mix of Tuya (€12) + Shelly (€25) where quality matters = **€270-330**

## Quick Links

**Home Assistant:**
- [Home Assistant](https://www.home-assistant.io/)
- [HACS (Home Assistant Community Store)](https://hacs.xyz/)

**Phase 3 - Smart Lighting:**
- [Shelly Wall Switch](https://www.shelly.com/products/shelly-wall-switch-with-1-button) - Premium option
- [Tuya/Smart Life Integration](https://www.home-assistant.io/integrations/tuya/) - Budget option
- [Sonoff Products](https://sonoff.tech/) - Alternative option
- [Smart Switch Comparison Guide](docs/smart-switch-guide.md) - Decision process

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
