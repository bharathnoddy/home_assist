# Alexa Integration

## Overview
Connect Home Assistant to Alexa for:
- Voice control of all HA devices
- "Alexa, turn on living room lights"
- Alexa routines triggering HA automations

---

## Integration Options

| Method | Pros | Cons |
|--------|------|------|
| **Nabu Casa** | Easiest, 5-min setup, supports all features | EUR 6.50/month |
| **Manual Skill** | Free | Complex setup, needs AWS account, HTTPS required |

**Recommendation:** Start with Nabu Casa (free 1-month trial), switch to manual later if desired.

---

## Option A: Nabu Casa (Recommended)

### Step 1: Subscribe to Nabu Casa

1. Go to **Settings** → **Home Assistant Cloud**
2. Click **Start your free trial**
3. Create account at https://www.nabucasa.com/
4. Enter email and payment (not charged for 31 days)

### Step 2: Enable Alexa Integration

1. In HA, go to **Settings** → **Home Assistant Cloud**
2. Find **Alexa** section
3. Click **Enable Alexa**

### Step 3: Link in Alexa App

1. Open **Alexa app** on your phone
2. Go to **More** → **Skills & Games**
3. Search for **"Home Assistant"**
4. Click **Enable to Use**
5. Sign in with your **Nabu Casa account**
6. Alexa will discover your devices

### Step 4: Discover Devices

1. Say: **"Alexa, discover my devices"**
2. Or: Alexa app → Devices → + → Add Device → Other → Discover

### Step 5: Choose Exposed Entities

By default, many entities are exposed. To customize:

1. **Settings** → **Home Assistant Cloud** → **Alexa**
2. Click **Manage Entities**
3. Toggle which entities Alexa can see/control
4. Rename entities for easier voice commands

---

## Option B: Manual Setup (Free, Advanced)

### Prerequisites
- Domain name with HTTPS (use DuckDNS)
- AWS account (free tier)
- Technical comfort with AWS Lambda

### High-Level Steps

1. Set up DuckDNS + Let's Encrypt (see remote-access.md)
2. Create AWS Developer Account
3. Create Alexa Smart Home Skill
4. Create Lambda Function
5. Configure HA with skill credentials
6. Link accounts

**Full guide:** https://www.home-assistant.io/integrations/alexa.smart_home/

---

## Organizing Devices in Alexa

### Create Rooms in Alexa App

1. Open Alexa app
2. **Devices** → **+** → **Add Group**
3. Create rooms: Living Room, Bedroom, Kitchen, etc.
4. Assign devices to rooms

### Benefits
- "Alexa, turn off the bedroom" (all bedroom devices)
- "Alexa, dim the living room to 50%"

---

## Useful Voice Commands

Once set up, try:

### Lights (Phase 3)
- "Alexa, turn on the lights"
- "Alexa, dim the living room to 30%"
- "Alexa, turn off all lights"

### Scenes/Scripts
- "Alexa, turn on movie mode"
- "Alexa, activate good night"

### Climate (Phase 5)
- "Alexa, set thermostat to 21"
- "Alexa, what's the temperature inside?"

### Information
- "Alexa, is the front door locked?"
- "Alexa, show me the front door camera" (Echo Show)

---

## Creating Alexa Routines with HA

### Example: "Alexa, I'm leaving"

1. **Alexa App** → **More** → **Routines**
2. **+** to create new routine
3. **When this happens:** Voice → "I'm leaving"
4. **Add action:**
   - Smart Home → Turn off all lights
   - Smart Home → Set thermostat to 16
   - Custom → "Goodbye, have a nice day"
5. **Save**

### Example: "Alexa, good morning"

1. Create routine with voice trigger "good morning"
2. Actions:
   - Turn on kitchen lights
   - Set brightness to 70%
   - Weather briefing
   - News briefing

---

## Exposing HA Scripts to Alexa

Create scripts in HA that appear as devices in Alexa:

### Example: Movie Mode Script

```yaml
# configuration.yaml or scripts.yaml
script:
  movie_mode:
    alias: "Movie Mode"
    sequence:
      - service: light.turn_off
        target:
          area_id: living_room
      - service: light.turn_on
        target:
          entity_id: light.tv_backlight
        data:
          brightness_pct: 20
          color_name: blue
```

This appears in Alexa as "Movie Mode" - say "Alexa, turn on movie mode"

---

## Troubleshooting

### "Alexa doesn't understand device name"
- Rename entity in HA Cloud settings
- Use simpler names: "bedroom light" not "bedroom_ceiling_light_01"
- Avoid special characters

### "Device not responding"
- Check HA is running
- Verify entity is exposed in HA Cloud
- Say "Alexa, discover devices" to refresh

### Nabu Casa connection issues
- Check internet connection
- Settings → HA Cloud → Check status
- May need to reconnect after HA updates

### Commands work but slowly
- Normal for cloud-based control
- Nabu Casa routes through cloud
- Local voice assistants (future) are faster

---

## Verification Checklist

- [ ] Nabu Casa account created (or manual skill set up)
- [ ] Alexa skill linked to Home Assistant
- [ ] Devices discovered in Alexa app
- [ ] Voice command test: "Alexa, turn on [device]"
- [ ] Devices organized into rooms in Alexa
