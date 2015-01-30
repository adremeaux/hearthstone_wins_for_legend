//
//  AppDelegate.swift
//  HearthstoneLegend
//
//  Created by Andy Dremeaux on 1/30/15.
//  Copyright (c) 2015 Andy Dremeaux. All rights reserved.

import Cocoa

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!

	let trials = 10000
	let starsPerRank = 5
	let bonusCutoff = 5
	let startingRank = 15
	let winPercent:(UInt32, UInt32) = (50, 100) //ex: 525, 1000 == 525/1000 == 52.5% win

	var total = 0
	
	func applicationDidFinishLaunching(aNotification: NSNotification) {
		for i in 0..<trials {
			var stars = 0
			var streak = 0
			var attempts = 0
			var longestStreak = 0
			var flips = (heads: 0, tails: 0)
			let starTarget = startingRank * starsPerRank + 1
			let starBonusCutoff = (startingRank - bonusCutoff) * starsPerRank + 1
			while stars < starTarget {
				attempts++
				if arc4random_uniform(winPercent.1) >= winPercent.0 {
					stars--
					flips.tails++
					streak = 0
				} else {
					stars++
					flips.heads++
					if ++streak >= 3 && stars <= starBonusCutoff {
						stars++
					}
					longestStreak = max(streak, longestStreak)
				}
				
				if stars >= starTarget {
					total += attempts
					//println("attempts: \(attempts)\t| streak \(longestStreak)\t| \(flips)")
					break
				}
			}
		}
		println("average: \(total / trials)")
	}
}

