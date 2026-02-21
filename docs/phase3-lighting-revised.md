# Phase 3: Smart Lighting - Revised Plan

**Updated Strategy:** Shelly relays + normal bulbs (better for 80% switch / 20% app usage pattern)

---

## Why Shelly Instead of Smart Bulbs

| Your Need | Smart Bulbs | Shelly + Normal Bulbs |
|-----------|-------------|----------------------|
| Physical switch works | ❌ Need to tape switches | ✅ Switches work normally |
| App control (remote off) | ✅ Yes | ✅ Yes |
| Family convenience | ❌ Change habits | ✅ No change needed |
| Cost per light | €10-15 | €3-5 bulb + €10-12 relay |
| Reliability | ⚠️ WiFi per bulb | ✅ One relay per room |

**Decision:** Shelly relays are better suited for your use case!

---

## Hardware Plan

### Core Components

| Item | Quantity | Purpose | Cost (EUR) |
|------|----------|---------|------------|
| **Shelly 1** | 10-12 | Main floor lighting | €10-12 each |
| **Shelly Plus 1 PM Mini** | 2-3 | Tight spaces (if needed) | €15 each |
| **Normal LED bulbs** | 15-20 | Actual light sources | €3-5 each |

### Optional: Kids Room RGB

| Item | Quantity | Purpose | Cost (EUR) |
|------|----------|---------|------------|
| **Sonoff ZBDongle-E** | 1 | Zigbee coordinator | €15-20 |
| **IKEA Tradfri RGB E27** | 2-3 | Kids room color lights | €15-20 each |

**Total: €200-250** (vs €250+ for all smart bulbs)

---

## Installation Prerequisites

### Check Before Ordering

1. **Switch box depth** - need 35mm+ behind switch
2. **Neutral wire availability** - Shelly needs neutral (blue wire)
3. **Number of switch locations** - count actual switches, not bulbs
4. **Electrical knowledge** - comfortable with basic wiring?

### Common Dutch Switch Wiring

Most Dutch homes have:
- ✅ **Brown:** Live (L)
- ✅ **Blue:** Neutral (N) - Shelly needs this!
- ✅ **Green/Yellow:** Earth
- ⚠️ **Black:** Switched live

**Important:** If no neutral in switch box, need different solution (Shelly 1L or Fibaro)

---

## Installation Plan

### Week 1: Test Installation (1-2 Switches)

1. **Order 2x Shelly 1** first
2. Choose test locations:
   - Living room (high usage)
   - Bedroom (test app control)
3. Install behind existing switches
4. Test via Home Assistant

### Week 2-3: Roll Out (If Test Success)

1. Order remaining Shelly units
2. Install room by room:
   - **Priority 1:** Rooms you forget to turn off
   - **Priority 2:** Common areas (living, kitchen)
   - **Priority 3:** Bedrooms, bathrooms

### Week 4: Kids Room RGB (Optional)

1. Order Zigbee coordinator + RGB bulbs
2. Install in kids room only
3. Set up color automations

---

## Shelly 1 Installation Steps

### Safety First
⚠️ **Turn OFF power at breaker before ANY electrical work!**

### Wiring Diagram

```
Breaker Box                Switch Box                  Light
─────────                 ─────────                   ─────
[L] Brown ────────────→ [L] Shelly [O] ────────────→ [Bulb]
[N] Blue ─────────────→ [N] Shelly
                         [I] ←─ Switch (existing)
```

### Steps

1. **Turn off power** at breaker
2. Remove switch plate cover
3. Identify wires:
   - Brown (L) - live from breaker
   - Blue (N) - neutral
   - Black - to light
4. Connect Shelly:
   - **L** → Brown (live in)
   - **N** → Blue (neutral)
   - **I** → Existing switch wire
   - **O** → Black (to light)
5. Tuck Shelly behind switch
6. Replace cover
7. Turn power back on

---

## Home Assistant Integration

### Add Shelly Integration

1. **Settings** → **Devices & Services**
2. Click **"+ Add Integration"**
3. Search: **"Shelly"**
4. Auto-discovers all Shelly devices on network

### What You Get Per Shelly

- `switch.living_room_light` - ON/OFF control
- `sensor.living_room_power` - Current power usage (if Shelly Plus 1 PM)
- `sensor.living_room_energy` - Total energy consumption
- Automations and scenes

---

## Automations Examples

### Auto-Off Forgotten Lights

```yaml
alias: "Auto-off living room after 30min no motion"
trigger:
  - platform: state
    entity_id: binary_sensor.living_room_motion
    to: "off"
    for:
      minutes: 30
condition:
  - condition: state
    entity_id: switch.living_room_light
    state: "on"
action:
  - service: switch.turn_off
    target:
      entity_id: switch.living_room_light
```

### Turn Off All Lights (Leaving Home)

```yaml
alias: "All lights off when leaving"
trigger:
  - platform: state
    entity_id: person.bharath
    to: "not_home"
action:
  - service: switch.turn_off
    target:
      entity_id:
        - switch.living_room_light
        - switch.bedroom_light
        - switch.kitchen_light
```

### Bedtime Routine

```yaml
alias: "Bedtime - Turn off downstairs"
trigger:
  - platform: time
    at: "23:00:00"
action:
  - service: switch.turn_off
    target:
      entity_id:
        - switch.living_room_light
        - switch.kitchen_light
  - service: notify.mobile_app
    data:
      message: "Downstairs lights turned off for bedtime"
```

---

## Kids Room RGB Setup (Optional)

If you want color changing lights just for kids room:

### Hardware
- 1x Sonoff ZBDongle-E (€15-20)
- 2-3x IKEA Tradfri RGB bulbs (€15-20 each)

### Setup
1. Plug ZBDongle into Pi USB
2. **Settings** → **Devices & Services** → **Add Integration** → **"Zigbee Home Automation"**
3. Pair RGB bulbs
4. Control colors via app/automations

### Color Automations

```yaml
alias: "Kids bedtime - warm orange"
trigger:
  - platform: time
    at: "20:00:00"
action:
  - service: light.turn_on
    target:
      entity_id: light.kids_room
    data:
      brightness: 50
      rgb_color: [255, 140, 0]  # Orange
```

---

## Shopping List

### Phase 3A: Shelly Core Setup

| Item | Qty | Where to Buy | Est. Cost |
|------|-----|--------------|-----------|
| Shelly 1 | 10 | bol.com, Amazon.nl | €120 |
| Shelly Plus 1 PM Mini | 2 | (if needed for tight spaces) | €30 |
| LED bulbs (normal) | 15 | IKEA, Action | €60 |
| **Subtotal** | | | **€210** |

### Phase 3B: Kids Room RGB (Optional)

| Item | Qty | Where to Buy | Est. Cost |
|------|-----|--------------|-----------|
| Sonoff ZBDongle-E | 1 | AliExpress, Amazon | €18 |
| IKEA Tradfri RGB E27 | 3 | IKEA | €54 |
| **Subtotal** | | | **€72** |

**Total Phase 3: €210-282**

---

## Before You Order

### Checklist

- [ ] Count actual **switch locations** (not bulbs)
- [ ] Remove one switch cover to check:
  - [ ] Box depth (35mm+ ideal)
  - [ ] Neutral wire present (blue wire)
  - [ ] Comfortable with wiring
- [ ] Decide: Kids room RGB or skip?
- [ ] Order 2x Shelly 1 for test first

---

## Troubleshooting

### No Neutral Wire in Switch Box

**Solution 1:** Use **Shelly 1L** (no neutral needed)
- Costs €15-18
- Works without neutral
- Slightly more complex wiring

**Solution 2:** Run neutral from junction box
- Requires electrician
- Not recommended if unfamiliar

### Not Enough Space

**Solution:** Use **Shelly Plus 1 PM Mini**
- 20% smaller
- Costs €15 vs €10
- Fits in tighter spaces

### Shelly Not Discovered in HA

1. Check Shelly is on same WiFi network
2. Try manual IP: Settings → Integrations → Add Shelly → Enter IP
3. Update Shelly firmware via Shelly app

---

## Success Criteria

- [ ] All main lights controllable via switch (works normally)
- [ ] All lights controllable via app (remote off)
- [ ] Dashboard shows all switches
- [ ] At least one automation working (e.g., auto-off)
- [ ] Family doesn't notice any change (good sign!)

---

## Next: Phase 4 Preview

With Shelly relays in place, Phase 4 will add:
- Motion sensors (IKEA Tradfri)
- Automations: lights on when motion detected
- Away mode: turn off forgotten lights
- Energy monitoring per room (if using Shelly Plus PM)
