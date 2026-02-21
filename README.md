# Home Automation Project

Central smart home system using **Home Assistant** on Raspberry Pi, integrating existing devices and adding smart lighting across 3 floors.

## Current Setup

| Device | Status | Integration |
|--------|--------|-------------|
| Raspberry Pi 5 | ✅ Running | Home Assistant OS @ 192.168.178.2 |
| Ring Doorbells (x2) | ✅ Connected | Front + back door with motion & camera |
| P1 Meter (HomeWizard) | ✅ Connected | Real-time electricity monitoring |
| Solax Solar Inverter | ✅ Connected | Production monitoring |
| Energy Dashboard | ✅ Active | Import/export tracking |
| Alexa | Planned | Voice control hub (Phase 1 - optional) |
| Smart Lights | Planned | IKEA Tradfri, ~10-20 bulbs (Phase 3) |
| Water Meter (Vitens) | Future | Requires HomeWizard Water Meter |
| District Heating (Vattenfall) | Future | Awaiting automatic reading support |

## Architecture

```
                    ┌─────────────────┐
                    │     Alexa       │
                    │  (Voice Control)│
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │  Home Assistant │
                    │  (Raspberry Pi) │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
   ┌────▼────┐         ┌─────▼─────┐        ┌────▼────┐
   │  Ring   │         │  Zigbee   │        │ Energy  │
   │Doorbell │         │  Network  │        │ Monitor │
   └─────────┘         └─────┬─────┘        └────┬────┘
                             │                   │
                    ┌────────┴────────┐    ┌─────┴─────┐
                    │  Smart Lights   │    │ P1 Meter  │
                    │  (All Floors)   │    │ + Solar   │
                    └─────────────────┘    └───────────┘
```

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

### 🔲 Phase 3: Smart Lighting (Planned)
- IKEA Tradfri bulbs via Zigbee coordinator
- ~10-20 bulbs across 3 floors
- Basic lighting automations

### 🔲 Phase 4: Advanced Automations (Planned)
- Presence detection
- Smart routines (morning, evening, away)
- Security automations (Ring motion → lights)
- Energy optimization

### 🔲 Phase 5: Future Enhancements
- Water monitoring (HomeWizard Water Meter)
- District heating (when Vattenfall enables auto-reading)
- Climate control
- Wall-mounted tablet dashboard

## Documentation

- [Detailed Implementation Plan](docs/PLAN.md)
- [Hardware Shopping List](docs/PLAN.md#hardware-shopping-list)

## Hardware Budget

**Estimated Total: €250-400** (excluding Raspberry Pi)

## Quick Links

- [Home Assistant](https://www.home-assistant.io/)
- [HACS (Home Assistant Community Store)](https://hacs.xyz/)
- [Solax Modbus Integration](https://github.com/wills106/homeassistant-solax-modbus)
- [DSMR Integration](https://www.home-assistant.io/integrations/dsmr/)

## License

This project is for personal use.
