# Dividend ETF Tracker

An iOS app that displays dividend ETF recommendations based on historical analysis data.

## Features

- **ETF List View**: Browse 10 dividend-focused ETFs with key metrics
- **Sort Options**: Sort by Score, Yield, or Performance
- **Share Calculator**: Calculate potential dividend payments based on number of shares
- **Detailed View**: Comprehensive information for each ETF including:
  - Current price and dividend yield
  - Last dividend payment details with ex-date
  - Payment frequency (Monthly, Quarterly, etc.)
  - Performance metrics and expense ratios
  - Links to official ETF sources

## Data Source

The app uses the `etf_analysis_20251022.json` file containing:
- 10 popular dividend ETFs (DIV, SPYD, SCHD, DVY, HDV, SDY, VYM, NOBL, DGRO, VIG)
- Historical dividend payment data
- Performance metrics
- Official source links for upcoming dividend dates

## Structure

```
DividendETFTracker/
├── DividendETFTrackerApp.swift     # App entry point
├── Models/
│   ├── ETFData.swift                # Data models for ETF
│   └── ETFDataManager.swift         # Data loading and sorting
├── Views/
│   ├── ContentView.swift            # Main list view
│   └── ETFDetailView.swift          # Detailed ETF view
├── etf_analysis_20251022.json       # ETF data
└── Assets.xcassets/                 # App assets
```

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.0+

## How to Run

1. Open `DividendETFTracker.xcodeproj` in Xcode
2. Select your target device or simulator
3. Press `Cmd + R` to build and run

## Usage

1. **Browse ETFs**: View the list of dividend ETFs sorted by score (default)
2. **Adjust Shares**: Enter the number of shares you own to see potential dividend payments
3. **Sort**: Use the segmented control to sort by Score, Yield, or Performance
4. **View Details**: Tap any ETF to see comprehensive information
5. **Check Official Sources**: Tap the link in the detail view to visit the ETF's official page for upcoming dividend dates

## Notes

- Data shown is historical (last dividend payment)
- For upcoming dividend dates, check the official source links
- Future dividends are typically announced 2-4 weeks before ex-date
- Also check your broker's dividend calendar for confirmed dates

## Updating Data

To update the ETF data:
1. Run the Python analyzer: `python3 etf_dividend_analyzer.py`
2. Copy the generated JSON file to `DividendETFTracker/DividendETFTracker/`
3. Update the filename in `ETFDataManager.swift` if needed
4. Rebuild the app

## Related Files

This app uses data from the ETF Dividend Analyzer Python script located in `../ETF 10:22:25/`.
