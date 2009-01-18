From: Tony Vroon <tony@linx.net>
Subject: [PATCH RFT] fujitsu-laptop: Use RFKILL support bitmask from firmware
Date: Sun, 18 Jan 2009 01:53:03 +0000 (GMT)
Message-ID: <20090118015303.DF36D10077@gold.linx.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:35659 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755330AbZARBxG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Jan 2009 20:53:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Stephen Gildea <stepheng+linux@gildea.com>, Peter Gruber <nokos@gmx.net>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org

Up until now, we polled the rfkill status for every incoming FUJ02E3 ACPI event. 
It turns out that the firmware has a bitmask which indicates what rfkill-related 
state it can report.
The rfkill_supported bitmask is now used to avoid polling for rfkill at all in 
the notification handler if there is no support. Also, it is used in the platform 
device callbacks. As before we register all callbacks and report "unknown" if the 
firmware does not give us status updates for that particular bit.

This was fed through checkpatch.pl and tested on the S6420 platform.
Jonathan, your platform is of particular importance as you are the only tester 
on a platform with no S000 function in the DSDT. Please confirm you still get a 
unknown status in the platform files. With debugging on full, you should see the 
0x1000 0x4 0x0 0x0 call disappear from your trace entirely.

Signed-off-by: Tony Vroon <tony@linx.net>

--- linux-2.6/drivers/platform/x86/fujitsu-laptop.c.orig	2009-01-18 01:05:55.000000000 +0000
+++ linux-2.6/drivers/platform/x86/fujitsu-laptop.c	2009-01-18 01:21:27.000000000 +0000
@@ -166,6 +166,7 @@
 	struct platform_device *pf_device;
 	struct kfifo *fifo;
 	spinlock_t fifo_lock;
+	int rfkill_supported;
 	int rfkill_state;
 	int logolamp_registered;
 	int kblamps_registered;
@@ -526,7 +527,7 @@
 show_lid_state(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	if (fujitsu_hotkey->rfkill_state == UNSUPPORTED_CMD)
+	if (!(fujitsu_hotkey->rfkill_supported & 0x100))
 		return sprintf(buf, "unknown\n");
 	if (fujitsu_hotkey->rfkill_state & 0x100)
 		return sprintf(buf, "open\n");
@@ -538,7 +539,7 @@
 show_dock_state(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	if (fujitsu_hotkey->rfkill_state == UNSUPPORTED_CMD)
+	if (!(fujitsu_hotkey->rfkill_supported & 0x200))
 		return sprintf(buf, "unknown\n");
 	if (fujitsu_hotkey->rfkill_state & 0x200)
 		return sprintf(buf, "docked\n");
@@ -550,7 +551,7 @@
 show_radios_state(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	if (fujitsu_hotkey->rfkill_state == UNSUPPORTED_CMD)
+	if (!(fujitsu_hotkey->rfkill_supported & 0x20))
 		return sprintf(buf, "unknown\n");
 	if (fujitsu_hotkey->rfkill_state & 0x20)
 		return sprintf(buf, "on\n");
@@ -928,8 +929,17 @@
 		; /* No action, result is discarded */
 	vdbg_printk(FUJLAPTOP_DBG_INFO, "Discarded %i ringbuffer entries\n", i);
 
-	fujitsu_hotkey->rfkill_state =
-		call_fext_func(FUNC_RFKILL, 0x4, 0x0, 0x0);
+	fujitsu_hotkey->rfkill_supported =
+		call_fext_func(FUNC_RFKILL, 0x0, 0x0, 0x0);
+
+	/* Make sure our bitmask of supported functions is cleared if the
+	   RFKILL function block is not implemented, like on the S7020. */
+	if (fujitsu_hotkey->rfkill_supported == UNSUPPORTED_CMD)
+		fujitsu_hotkey->rfkill_supported = 0;
+
+	if (fujitsu_hotkey->rfkill_supported)
+		fujitsu_hotkey->rfkill_state =
+			call_fext_func(FUNC_RFKILL, 0x4, 0x0, 0x0);
 
 	/* Suspect this is a keymap of the application panel, print it */
 	printk(KERN_INFO "fujitsu-laptop: BTNI: [0x%x]\n",
@@ -1005,8 +1015,9 @@
 
 	input = fujitsu_hotkey->input;
 
-	fujitsu_hotkey->rfkill_state =
-		call_fext_func(FUNC_RFKILL, 0x4, 0x0, 0x0);
+	if (fujitsu_hotkey->rfkill_supported)
+		fujitsu_hotkey->rfkill_state =
+			call_fext_func(FUNC_RFKILL, 0x4, 0x0, 0x0);
 
 	switch (event) {
 	case ACPI_FUJITSU_NOTIFY_CODE1:
