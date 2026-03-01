# Smart Switch Selection Guide

## Decision: Smart Switches vs Shelly Relays

**Date:** 2026-03-01
**Status:** DECIDED - Using Smart Switches

---

## The Decision

After initial planning to use Shelly Plus 1 Mini relays behind existing switches, we've pivoted to using **smart switches** that replace the physical switches entirely.

### Why the Change?

**Original Plan:** Shelly Plus 1 Mini behind switches
- Keep existing switch look
- Physical switches still work
- More complex installation (WAGO connectors, multiple jumper wires)
- Crowded junction boxes
- Harder for beginners

**New Plan:** Smart Switches (replace physical switches)
- Simple installation (same as replacing normal switch)
- No WAGO connectors needed
- Future-proof and easy to maintain
- Only €5-10 more per switch
- **Much better for beginner skill level**

---

## Smart Switch Options Evaluated

### Option 1: Tuya WiFi Touch Switch (Budget Choice)
**Price:** €10-15 per switch
**Total for 15:** €150-225

**Pros:**
- ✅ Cheapest option
- ✅ Easy installation (3-4 wires)
- ✅ Touch panel (modern look)
- ✅ Works with HA via Tuya integration
- ✅ Many design options

**Cons:**
- ⚠️ Quality varies by seller
- ⚠️ Cloud-dependent (unless LocalTuya)
- ⚠️ Some require account

**Best for:** Budget-conscious, 12-15 switches to install

---

### Option 2: Sonoff MINI R4 (Hidden Option)
**Price:** €13-18 per switch
**Total for 15:** €195-270

**Pros:**
- ✅ Fits behind existing switches (keep current look)
- ✅ Great HA integration
- ✅ Local control possible
- ✅ Reliable brand

**Cons:**
- ⚠️ Still need WAGO connectors (like Shelly)
- ⚠️ Hidden in box (harder to replace)
- ⚠️ More complex than replacement switches

**Best for:** Want to keep existing switch appearance

---

### Option 3: Shelly Wall Switch (Premium Choice)
**Price:** €22-28 per switch
**Total for 15:** €330-420

**Pros:**
- ✅ Best quality and reliability
- ✅ 100% local control (no cloud needed)
- ✅ Excellent HA integration
- ✅ Professional grade
- ✅ Physical rocker switch (not just touch)

**Cons:**
- ⚠️ Most expensive
- ⚠️ Limited design options

**Best for:** Want absolute best quality and local control

---

## Our Recommendation

### Phase 1: Test with Budget Option
**Order for testing:**
- 2-3 × Tuya Touch Switch (€12 each) = €24-36
- Test installation and HA integration
- Evaluate quality and family acceptance

### Phase 2: Rollout Strategy
**If Tuya works well:**
- Order 12-13 more Tuya switches
- Total cost: €180-225 (excellent value!)

**If want better quality:**
- Mix approach:
  - High-traffic areas: Shelly Wall Switch (€25)
  - Other areas: Tuya Switch (€12)
  - Total: €270-330 (balanced approach)

**If budget allows:**
- All Shelly Wall Switches
- Total: €375-420 (premium quality)

---

## Installation Comparison

### Tuya/Shelly Wall Switch (Simple):
```
OLD SWITCH (2 wires):          NEW SMART SWITCH (3 wires):
TOP: Black (to light)          L-out: Black (to light)
BOTTOM: 2 Browns (power)       L-in: 2 Browns (power)
                               N: 2 Blues (neutral)

Time: 15-30 minutes
Difficulty: ⭐ Easy (same as replacing switch!)
Tools: Screwdriver only
```

### Sonoff MINI / Shelly Relay (Complex):
```
Need WAGO connectors + jumper wires
Multiple connection points (5-8)
Tight junction box space
Must wire switch back to relay

Time: 1-2 hours first time
Difficulty: ⭐⭐⭐⭐ Complex
Tools: Wire strippers, WAGO connectors, jumpers
```

**Winner:** Smart switches are 4× faster and 10× simpler!

---

## Wiring Requirements

**All options require:**
- ✅ Neutral wire (blue) in junction box
- ✅ Live wire (brown)
- ✅ Load wire (black) to light

**We confirmed:** All switches in the house have neutral wires! ✅

---

## Home Assistant Integration

### Tuya Switches
```yaml
Integration: Tuya
Setup: Cloud account required
Local control: Via LocalTuya (advanced)
Auto-discovery: Yes
Reliability: Good (8/10)
```

### Shelly Wall Switch
```yaml
Integration: Shelly (native)
Setup: No account needed
Local control: Built-in (100% local)
Auto-discovery: Yes
Reliability: Excellent (10/10)
```

### Sonoff MINI R4
```yaml
Integration: eWeLink or Zigbee
Setup: eWeLink account or Zigbee hub
Local control: Via DIY mode or Zigbee
Auto-discovery: Yes
Reliability: Very Good (9/10)
```

---

## Cost-Benefit Analysis

### Shelly Plus 1 Mini (Original Plan)
```
Cost per switch:
- Shelly Plus 1 Mini: €12-15
- WAGO connectors: €0.50
- Jumper wire: €0.30
- Your time/stress: HIGH
= €12.80 + frustration

Total 15 switches: €192 + LOTS of stress
```

### Smart Switches (New Plan)
```
Cost per switch:
- Tuya option: €12 (same price!)
- No extras needed: €0
- Your time/stress: LOW
= €12 + peace of mind

Total 15 switches: €180 + easy installation
```

**Result:** Same cost, WAY easier! Smart switches win! 🎯

---

## Family Acceptance

**Considerations:**
- Will family adapt to touch switches? (vs physical rocker)
- Do they care about appearance change?
- Importance of "it just works"

**Our situation:**
- Primary user comfortable with tech
- Family can adapt to touch switches
- Appearance not critical (functional > aesthetic)

**Decision:** Touch switches acceptable, prioritize ease of installation

---

## Where to Buy

### Amazon.nl (Recommended)
- Fast shipping (1-2 days)
- Easy returns
- Search: "Tuya smart switch EU neutral" or "Shelly Wall Switch"

### bol.com
- Dutch platform
- Good return policy
- Similar prices

### AliExpress (Bulk Orders)
- Cheapest (€8-12 per switch)
- 2-4 weeks shipping
- No easy returns
- Good for bulk (15+ switches)

---

## Testing Phase Plan

### Week 1: Order Test Units
```
2 × Tuya Touch Switch @ €12 = €24
Test in 2 different rooms
```

### Week 2: Installation & Testing
```
Install both switches
Test HA integration
Check family acceptance
Evaluate quality
```

### Week 3: Decision
```
If satisfied: Order 13 more
If not: Try Shelly Wall Switch (2 units)
Compare and decide
```

### Week 4-8: Rollout
```
Install 2-3 switches per weekend
Complete all 15 switches
```

---

## Learning from Shelly Plus 1 Mini Experience

**What we discovered:**
1. ✅ Ordered Shelly Plus 1 Mini (€12-15)
2. ⚠️ Opened packaging (slightly damaged)
3. 🔍 Researched installation - found it complex
4. 💡 Realized smart switches are simpler
5. ✅ Can return Shelly Mini (Amazon policy)
6. 🎯 Pivoted to smart switch approach

**Lessons learned:**
- Research installation complexity BEFORE buying
- Sometimes "cheaper" option costs more (time/stress)
- €5-10 extra for simplicity is WORTH IT
- Test with 2-3 units before bulk order

---

## Final Decision

**WINNER: Tuya Smart Switch (with option to upgrade)**

**Rationale:**
1. ✅ Same price as Shelly Plus 1 Mini (~€12)
2. ✅ 4× easier installation
3. ✅ No extra parts needed
4. ✅ Future-proof (easy to replace)
5. ✅ Good enough quality for budget
6. ✅ Option to upgrade critical areas to Shelly later

**Action items:**
- [ ] Order 2-3 Tuya switches for testing
- [ ] Install and test for 1 week
- [ ] Evaluate and decide on rollout
- [ ] Order remaining switches
- [ ] Install 2-3 per weekend

---

## Resources

**Product Links:**
- [Shelly Wall Switch 1 Gang](https://www.shelly.com/products/shelly-wall-switch-with-1-button)
- Amazon.nl search: "BSEED Tuya Smart Switch 1 Gang EU"
- Amazon.nl search: "Sonoff MINI R4"

**Integration Guides:**
- [Tuya HA Integration](https://www.home-assistant.io/integrations/tuya/)
- [Shelly HA Integration](https://www.home-assistant.io/integrations/shelly/)
- [LocalTuya (Advanced)](https://github.com/rospogrigio/localtuya)

**Installation Help:**
- See: `/Users/bharath.nadar/repo/home_automation/home_assist/docs/` (this conversation!)
- Home Assistant Community Forums
- YouTube: "Smart switch installation tutorial"

---

**Last Updated:** 2026-03-01
**Status:** Decision made, ready to order test units
**Next Step:** Order 2-3 Tuya switches from Amazon.nl
