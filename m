From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/26] ACPI: thinkpad-acpi: improve thinkpad-acpi input device documentation
Date: Thu, 21 Feb 2008 04:38:01 -0500
Message-ID: <d0788cfbae0eddf13d5f2591acb1b407ba041d71.1203586624.git.len.brown@intel.com>
References: <1203586691-1234-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:15600 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759204AbYBUJjL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:39:11 -0500
In-Reply-To: <1203586691-1234-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix a few spelling errors, and also document the EV_SW events thinkpad-acpi
can issue.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/laptops/thinkpad-acpi.txt |   48 +++++++++++++++++-------------
 1 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 0ae5708..91f688c 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -160,7 +160,7 @@ Hot keys
 procfs: /proc/acpi/ibm/hotkey
 sysfs device attribute: hotkey_*
 
-In a ThinkPad, the ACPI HKEY handler is responsible for comunicating
+In a ThinkPad, the ACPI HKEY handler is responsible for communicating
 some important events and also keyboard hot key presses to the operating
 system.  Enabling the hotkey functionality of thinkpad-acpi signals the
 firmware that such a driver is present, and modifies how the ThinkPad
@@ -193,7 +193,7 @@ Not all bits in the mask can be modified.  Not all bits that can be
 modified do anything.  Not all hot keys can be individually controlled
 by the mask.  Some models do not support the mask at all, and in those
 models, hot keys cannot be controlled individually.  The behaviour of
-the mask is, therefore, higly dependent on the ThinkPad model.
+the mask is, therefore, highly dependent on the ThinkPad model.
 
 Note that unmasking some keys prevents their default behavior.  For
 example, if Fn+F5 is unmasked, that key will no longer enable/disable
@@ -288,7 +288,7 @@ sysfs notes:
 		in ACPI event mode, volume up/down/mute are reported as
 		separate events, but this behaviour may be corrected in
 		future releases of this driver, in which case the
-		ThinkPad volume mixer user interface semanthics will be
+		ThinkPad volume mixer user interface semantics will be
 		enforced.
 
 	hotkey_poll_freq:
@@ -308,7 +308,7 @@ sysfs notes:
 	hotkey_radio_sw:
 		if the ThinkPad has a hardware radio switch, this
 		attribute will read 0 if the switch is in the "radios
-		disabled" postition, and 1 if the switch is in the
+		disabled" position, and 1 if the switch is in the
 		"radios enabled" position.
 
 		This attribute has poll()/select() support.
@@ -339,7 +339,7 @@ sysfs notes:
 	wakeup_hotunplug_complete:
 		Set to 1 if the system was waken up because of an
 		undock or bay ejection request, and that request
-		was sucessfully completed.  At this point, it might
+		was successfully completed.  At this point, it might
 		be useful to send the system back to sleep, at the
 		user's choice.  Refer to HKEY events 0x4003 and
 		0x3003, below.
@@ -392,7 +392,7 @@ event	code	Key		Notes
 				Lenovo: battery
 
 0x1004	0x03	FN+F4		Sleep button (ACPI sleep button
-				semanthics, i.e. sleep-to-RAM).
+				semantics, i.e. sleep-to-RAM).
 				It is always generate some kind
 				of event, either the hot key
 				event or a ACPI sleep button
@@ -403,12 +403,12 @@ event	code	Key		Notes
 				time passes.
 
 0x1005	0x04	FN+F5		Radio.  Enables/disables
-				the internal BlueTooth hardware
+				the internal Bluetooth hardware
 				and W-WAN card if left in control
 				of the firmware.  Does not affect
 				the WLAN card.
 				Should be used to turn on/off all
-				radios (bluetooth+W-WAN+WLAN),
+				radios (Bluetooth+W-WAN+WLAN),
 				really.
 
 0x1006	0x05	FN+F6		-
@@ -417,7 +417,7 @@ event	code	Key		Notes
 				Do you feel lucky today?
 
 0x1008	0x07	FN+F8		IBM: toggle screen expand
-				Lenovo: configure ultranav
+				Lenovo: configure UltraNav
 
 0x1009	0x08	FN+F9		-
 	..	..		..
@@ -447,7 +447,7 @@ event	code	Key		Notes
 0x1011	0x10	FN+END		Brightness down.  See brightness
 				up for details.
 
-0x1012	0x11	FN+PGUP		Thinklight toggle.  This key is
+0x1012	0x11	FN+PGUP		ThinkLight toggle.  This key is
 				always handled by the firmware,
 				even when unmasked.
 
@@ -469,7 +469,7 @@ event	code	Key		Notes
 				key is always handled by the
 				firmware, even when unmasked.
 
-0x1018	0x17	THINKPAD	Thinkpad/Access IBM/Lenovo key
+0x1018	0x17	THINKPAD	ThinkPad/Access IBM/Lenovo key
 
 0x1019	0x18	unknown
 ..	..	..
@@ -488,6 +488,12 @@ If a key is mapped to KEY_UNKNOWN, it generates an input event that
 includes an scan code.  If a key is mapped to anything else, it will
 generate input device EV_KEY events.
 
+In addition to the EV_KEY events, thinkpad-acpi may also issue EV_SW
+events for switches:
+
+SW_RADIO	T60 and later hardare rfkill rocker switch
+SW_TABLET_MODE	Tablet ThinkPads HKEY events 0x5009 and 0x500A
+
 Non hot-key ACPI HKEY event map:
 0x5001		Lid closed
 0x5002		Lid opened
@@ -507,7 +513,7 @@ The above events are never propagated by the driver.
 
 0x3003		Bay ejection (see 0x2x05) complete, can sleep again
 0x4003		Undocked (see 0x2x04), can sleep again
-0x500B		Tablet pen insterted into its storage bay
+0x500B		Tablet pen inserted into its storage bay
 0x500C		Tablet pen removed from its storage bay
 0x5010		Brightness level changed (newer Lenovo BIOSes)
 
@@ -539,7 +545,7 @@ sysfs (it is read-only).
 If the hotkey_report_mode module parameter is set to 1 or 2, it cannot
 be changed later through sysfs (any writes will return -EPERM to signal
 that hotkey_report_mode was locked.  On 2.6.23 and later, where
-hotkey_report_mode cannot be changed at all, writes will return -EACES).
+hotkey_report_mode cannot be changed at all, writes will return -EACCES).
 
 hotkey_report_mode set to 1 makes the driver export through the procfs
 ACPI event interface all hot key presses (which are *also* sent to the
@@ -584,7 +590,7 @@ Sysfs notes:
 		0: disables Bluetooth / Bluetooth is disabled
 		1: enables Bluetooth / Bluetooth is enabled.
 
-	Note: this interface will be probably be superseeded by the
+	Note: this interface will be probably be superseded by the
 	generic rfkill class, so it is NOT to be considered stable yet.
 
 Video output control -- /proc/acpi/ibm/video
@@ -791,12 +797,12 @@ on the X40 (tpb is the ThinkPad Buttons utility):
 	1 - Related to "Volume up" key press
 	2 - Related to "Mute on" key press
 	3 - Related to "Access IBM" key press
-	4 - Related to "LCD brightness up" key pess
+	4 - Related to "LCD brightness up" key press
 	5 - Related to "LCD brightness down" key press
 	11 - Related to "toggle screen expansion" key press/function
 	12 - Related to "ThinkLight on"
 	13 - Related to "ThinkLight off"
-	14 - Related to "ThinkLight" key press (toggle thinklight)
+	14 - Related to "ThinkLight" key press (toggle ThinkLight)
 
 The cmos command interface is prone to firmware split-brain problems, as
 in newer ThinkPads it is just a compatibility layer.  Do not use it, it is
@@ -1024,7 +1030,7 @@ There are two interfaces to the firmware for direct brightness control,
 EC and CMOS.  To select which one should be used, use the
 brightness_mode module parameter: brightness_mode=1 selects EC mode,
 brightness_mode=2 selects CMOS mode, brightness_mode=3 selects both EC
-and CMOS.  The driver tries to autodetect which interface to use.
+and CMOS.  The driver tries to auto-detect which interface to use.
 
 When display backlight brightness controls are available through the
 standard ACPI interface, it is best to use it instead of this direct
@@ -1266,8 +1272,8 @@ experimental=1 parameter when loading the module.
 This feature shows the presence and current state of a W-WAN (Sierra
 Wireless EV-DO) device.
 
-It was tested on a Lenovo Thinkpad X60. It should probably work on other
-Thinkpad models which come with this module installed.
+It was tested on a Lenovo ThinkPad X60. It should probably work on other
+ThinkPad models which come with this module installed.
 
 Procfs notes:
 
@@ -1286,7 +1292,7 @@ Sysfs notes:
 		0: disables WWAN card / WWAN card is disabled
 		1: enables WWAN card / WWAN card is enabled.
 
-	Note: this interface will be probably be superseeded by the
+	Note: this interface will be probably be superseded by the
 	generic rfkill class, so it is NOT to be considered stable yet.
 
 Multiple Commands, Module Parameters
@@ -1356,7 +1362,7 @@ Sysfs interface changelog:
 		NVRAM is compiled out by the user because it is
 		unneeded/undesired in the first place).
 0x020101:	Marker for thinkpad-acpi with hot key NVRAM polling
-		and proper hotkey_mask semanthics (version 8 of the
+		and proper hotkey_mask semantics (version 8 of the
 		NVRAM polling patch).  Some development snapshots of
 		0.18 had an earlier version that did strange things
 		to hotkey_mask.
-- 
1.5.4

