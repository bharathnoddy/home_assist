# Home Automation Project

Central smart home system using **Home Assistant** on Raspberry Pi, integrating existing devices and adding smart lighting across 3 floors.

## Current Setup

| Device | Status | Integration |
|--------|--------|-------------|
| Alexa | Ready | Voice control hub |
| Ring Doorbells (x2) | Ready | Front + back door, connected to Alexa |
| Raspberry Pi 4 | Ready | Will run Home Assistant |
| Solax Solar Inverter | Ready | Currently using SolaxCloud app |
| P1 Meter (DSMR) | Ready | Direct cable connection |
| Smart Lights | Planned | IKEA Tradfri, ~10-20 bulbs |

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

## Project Phases

1. **Phase 1: Foundation** - Install Home Assistant, integrate Alexa + Ring
2. **Phase 2: Energy Monitoring** - P1 meter (DSMR) + Solax solar unified dashboard
3. **Phase 3: Smart Lighting** - IKEA Tradfri bulbs via Zigbee coordinator
4. **Phase 4: Advanced Automations** - Presence detection, routines, security
5. **Phase 5: Future Enhancements** - Climate control, sensors, wall tablets

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
