# Remote Access Setup

## Overview
Access your Home Assistant from anywhere (phone, work, traveling).

---

## Options Comparison

| Method | Difficulty | Cost | Features |
|--------|------------|------|----------|
| **Nabu Casa** | Easy | EUR 6.50/mo | Remote + Alexa + Google |
| **DuckDNS + Let's Encrypt** | Medium | Free | Remote only |
| **Tailscale VPN** | Easy | Free | Secure, no port forwarding |
| **Cloudflare Tunnel** | Medium | Free | Secure, no port forwarding |

---

## Option A: Nabu Casa (Easiest)

If you already set up Nabu Casa for Alexa, remote access is included!

### Enable Remote Access

1. **Settings** → **Home Assistant Cloud**
2. Toggle **Remote Control** to ON
3. Your remote URL: `https://xxxxxxxx.ui.nabu.casa`

### Access from Anywhere
- Use the Nabu Casa URL from any browser
- Or configure in HA mobile app

---

## Option B: DuckDNS + Let's Encrypt (Free)

### Step 1: Get DuckDNS Domain

1. Go to https://www.duckdns.org/
2. Sign in with Google/GitHub/etc.
3. Create a subdomain: `yourhome.duckdns.org`
4. Note your **token** (shown on dashboard)

### Step 2: Install DuckDNS Add-on

1. **Settings** → **Add-ons** → **Add-on Store**
2. Search **"DuckDNS"**
3. Install → Configure:

```yaml
domains:
  - yourhome.duckdns.org
token: your-duckdns-token-here
lets_encrypt:
  accept_terms: true
  certfile: fullchain.pem
  keyfile: privkey.pem
```

4. Start the add-on
5. Check logs - should show "OK" for DNS update

### Step 3: Configure Home Assistant for HTTPS

Edit `configuration.yaml`:

```yaml
http:
  ssl_certificate: /ssl/fullchain.pem
  ssl_key: /ssl/privkey.pem
```

Restart Home Assistant.

### Step 4: Port Forwarding on Router

1. Log into your router admin
2. Find Port Forwarding / NAT settings
3. Add rule:
   - External Port: **443**
   - Internal IP: Your HA IP (e.g., 192.168.1.100)
   - Internal Port: **8123**
   - Protocol: **TCP**

### Step 5: Test

1. From your phone (on mobile data, NOT WiFi):
2. Go to `https://yourhome.duckdns.org`
3. Should see HA login page with valid HTTPS

---

## Option C: Tailscale VPN (Secure & Free)

Tailscale creates a secure private network - no port forwarding needed.

### Step 1: Install Tailscale Add-on

1. **Settings** → **Add-ons** → **Add-on Store**
2. Search **"Tailscale"**
3. Install and start

### Step 2: Create Tailscale Account

1. Go to https://tailscale.com/
2. Sign up (free for personal use)
3. In add-on, click **Authenticate**
4. Approve the device in Tailscale admin

### Step 3: Install Tailscale on Phone/Computer

1. Install Tailscale app on your devices
2. Sign in with same account
3. All your devices are now on a private network

### Step 4: Access Home Assistant

- From any device with Tailscale:
- Access: `http://100.x.x.x:8123` (Tailscale IP)
- Or use the Tailscale device name

### Pros
- No port forwarding
- Works behind any firewall
- End-to-end encrypted
- Free for personal use

---

## Option D: Cloudflare Tunnel (Advanced, Free)

### Prerequisites
- Cloudflare account (free)
- Domain name (can be cheap, ~EUR 10/year)

### Setup Summary
1. Add domain to Cloudflare
2. Install Cloudflare Add-on in HA
3. Create tunnel
4. Configure to point to HA

**Full guide:** https://community.home-assistant.io/t/cloudflare-tunnel-setup/

---

## Mobile App Configuration

### Download App
- iOS: [App Store](https://apps.apple.com/app/home-assistant/id1099568401)
- Android: [Play Store](https://play.google.com/store/apps/details?id=io.homeassistant.companion.android)

### Configure Connection

1. Open app
2. Enter your HA URL:
   - Local: `http://192.168.1.100:8123`
   - Nabu Casa: `https://xxxxxx.ui.nabu.casa`
   - DuckDNS: `https://yourhome.duckdns.org`
3. Log in with your HA credentials

### Enable Internal/External URLs

For seamless switching between home and away:

1. In HA: **Settings** → **Companion App** → Your device
2. Set:
   - Internal URL: `http://192.168.1.100:8123`
   - External URL: `https://yourhome.duckdns.org` (or Nabu Casa URL)
3. App auto-switches based on WiFi

---

## Security Best Practices

1. **Use strong password** for HA account
2. **Enable 2FA** in HA (Profile → Multi-factor Authentication)
3. **Keep HA updated** for security patches
4. **Use HTTPS** for any public-facing access
5. **Review login attempts** in Settings → System → Logs

---

## Verification Checklist

- [ ] Remote access method chosen and configured
- [ ] Can access HA from phone on mobile data (not WiFi)
- [ ] HA mobile app installed and connected
- [ ] Internal + External URLs configured in app
- [ ] 2FA enabled for HA account
