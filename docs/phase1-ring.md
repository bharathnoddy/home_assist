# Ring Doorbell Integration

## Overview
Integrate your 2 Ring doorbells (front + back) with Home Assistant for:
- Live camera view in dashboard
- Motion detection events
- Doorbell press notifications
- Automation triggers

---

## Prerequisites
- Ring account with doorbells already set up
- Ring username/password
- 2FA enabled on Ring (recommended, supported)

---

## Step 1: Add Ring Integration

1. Go to **Settings** → **Devices & Services**
2. Click **+ Add Integration**
3. Search for **"Ring"**
4. Click to add

---

## Step 2: Authenticate

1. Enter your **Ring email** and **password**
2. If 2FA is enabled:
   - Ring will send a code to your email/phone
   - Enter the code when prompted
3. Click **Submit**

---

## Step 3: Verify Devices

After authentication, you should see:
- **2 cameras** (front door, back door)
- **2 doorbells** (ding sensors)
- **Motion sensors** for each camera
- **Battery sensors** (if battery-powered)

### Expected Entities

| Entity | Type | Description |
|--------|------|-------------|
| `camera.front_door` | Camera | Live feed front |
| `camera.back_door` | Camera | Live feed back |
| `binary_sensor.front_door_motion` | Motion | Front motion detected |
| `binary_sensor.back_door_motion` | Motion | Back motion detected |
| `binary_sensor.front_door_ding` | Ding | Front doorbell pressed |
| `binary_sensor.back_door_ding` | Ding | Back doorbell pressed |
| `sensor.front_door_battery` | Battery | Battery level (if applicable) |

---

## Step 4: Test the Integration

### View Live Feed
1. Go to **Overview** (dashboard)
2. Find camera cards or add them:
   - Click three dots → Edit Dashboard
   - Add Card → Picture Entity
   - Select `camera.front_door`

### Test Motion Detection
1. Walk past the front door
2. Check if `binary_sensor.front_door_motion` turns **on**
3. Developer Tools → States → Search "ring"

### Test Doorbell
1. Press doorbell button
2. Check if `binary_sensor.front_door_ding` triggers

---

## Step 5: Create Dashboard Cards

Add to your dashboard for quick viewing:

### Picture Glance Card (Both Cameras)
```yaml
type: picture-glance
title: Front Door
camera_image: camera.front_door
camera_view: live
entities:
  - binary_sensor.front_door_motion
  - binary_sensor.front_door_ding
```

### Grid of Both Doorbells
```yaml
type: grid
columns: 2
cards:
  - type: picture-entity
    entity: camera.front_door
    camera_view: live
    name: Front Door
  - type: picture-entity
    entity: camera.back_door
    camera_view: live
    name: Back Door
```

---

## Step 6: Basic Automations

### Notify on Any Doorbell Press

```yaml
alias: "Doorbell - Notify on press"
trigger:
  - platform: state
    entity_id:
      - binary_sensor.front_door_ding
      - binary_sensor.back_door_ding
    to: "on"
action:
  - service: notify.mobile_app_your_phone
    data:
      title: "Doorbell!"
      message: "Someone is at the {{ trigger.to_state.name | replace('_ding', '') }}"
      data:
        image: /api/camera_proxy/camera.{{ trigger.to_state.object_id | replace('_ding', '') }}
```

### Turn on Lights on Motion (Phase 3)

```yaml
alias: "Ring - Front motion lights"
trigger:
  - platform: state
    entity_id: binary_sensor.front_door_motion
    to: "on"
condition:
  - condition: sun
    after: sunset
action:
  - service: light.turn_on
    target:
      entity_id: light.front_porch  # Add in Phase 3
```

---

## Troubleshooting

### "Invalid authentication"
- Double-check Ring email/password
- Try logging into ring.com to verify credentials
- May need to re-authorize if you changed Ring password

### Camera feed not loading
- Ring limits concurrent streams
- Close Ring app on phone before viewing in HA
- Check your internet upload speed

### Motion not detecting
- Check motion sensitivity in Ring app
- Ensure motion detection is enabled in Ring app
- There's a ~30 second cooldown between motion events

### 2FA code not arriving
- Check spam folder
- Try SMS instead of email in Ring settings

---

## Verification Checklist

- [ ] Both cameras visible in Home Assistant
- [ ] Live feed working for both doorbells
- [ ] Motion detection triggering correctly
- [ ] Doorbell press events registering
- [ ] Dashboard cards showing camera feeds
