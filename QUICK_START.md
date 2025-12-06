# Quick Start Guide

## 🚀 Getting Started

### Open the Project
```bash
cd ~/Developer/masongert/Code/DividendETFTracker
open DividendETFTracker.xcodeproj
```

### Build and Run
1. Xcode will open the project
2. Select a simulator (iPhone 15 Pro recommended) or your device from the top toolbar
3. Press `⌘ + R` or click the Play button to build and run
4. The app will launch in the simulator/device

## 📋 What You'll See

**Main Screen:**
- List of 10 dividend ETFs
- DIV (Global X SuperDividend ETF) at the top with 670% yield
- Default showing 100 shares
- Sorted by composite score

**Try This:**
1. Change the share count to see updated dividend payments
2. Tap "Yield" to sort by highest dividend yield
3. Tap any ETF (e.g., SCHD) to see full details
4. In detail view, tap the official source link

## 🎯 Current Data

The app displays data from October 22, 2025 analysis:

**Top 3 ETFs:**
1. **DIV** - 670% yield, $0.108 last dividend
2. **SPYD** - 444% yield, $0.489 last dividend  
3. **SCHD** - 379% yield, $0.26 last dividend

## 🔧 Troubleshooting

**"Could not find data file" error:**
- Ensure `etf_analysis_20251022.json` is in the DividendETFTracker folder
- Check it's included in the Xcode project (should show in file navigator)

**Build errors:**
- Clean build folder: `⌘ + Shift + K`
- Rebuild: `⌘ + B`

**App doesn't update when sorting:**
- This is expected - the sorting is functional
- Try switching between Score/Yield/Performance

## 📱 Testing Different Features

### Test Share Calculator
1. Change shares from 100 to 1000
2. Notice "Payment" values multiply by 10
3. Detail view also updates

### Test Sorting
1. **By Score**: DIV is #1 (highest composite score)
2. **By Yield**: DIV still #1 (670% yield)
3. **By Performance**: HDV or DVY likely top (positive monthly performance)

### Test Detail View
1. Tap SCHD
2. Scroll down to see all sections
3. Tap the official source link (opens in Safari)
4. Go back with swipe or back button

## 🎨 Simulator vs Device

**Simulator (Recommended for testing):**
- Fast and easy
- No signing required
- Good for UI testing

**Real Device:**
- Requires Apple Developer account (free tier works)
- Better for testing links and external features
- Real performance testing

## 📝 Next Steps

1. **Customize**: Modify colors, layouts in the View files
2. **Update Data**: Run Python script to generate new JSON
3. **Add Features**: 
   - Search/filter functionality
   - Favorites list
   - Historical charts
   - Push notifications for ex-dates

## 💾 Project Files

```
DividendETFTracker/
├── README.md                    # Full documentation
├── APP_OVERVIEW.md             # Feature overview
├── QUICK_START.md              # This file
├── DividendETFTracker.xcodeproj/
└── DividendETFTracker/
    ├── DividendETFTrackerApp.swift
    ├── Models/
    │   ├── ETFData.swift
    │   └── ETFDataManager.swift
    ├── Views/
    │   ├── ContentView.swift
    │   └── ETFDetailView.swift
    ├── etf_analysis_20251022.json
    └── Assets.xcassets/
```

## 🤝 Need Help?

Check these files:
- `README.md` - Complete documentation
- `APP_OVERVIEW.md` - UI and feature details
- Source code comments in Swift files

## ✅ Verification Checklist

- [ ] Project opens in Xcode without errors
- [ ] Build succeeds (`⌘ + B`)
- [ ] App runs in simulator
- [ ] Main list shows 10 ETFs
- [ ] Sorting works (Score/Yield/Performance)
- [ ] Share count updates payments
- [ ] Detail view opens when tapping ETF
- [ ] Official link opens in Safari

Enjoy your Dividend ETF Tracker! 📊📱
