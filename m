From: Tony Vroon <tony@linx.net>
Subject: [PATCH 2.6.29] fujitsu-laptop: Use RFKILL support bitmask from firmware
Date: Mon,  2 Feb 2009 11:11:10 +0000 (GMT)
Message-ID: <20090202111110.83B1D10076@gold.linx.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gold.linx.net ([195.66.232.40]:40791 "EHLO gold.linx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbZBBLLN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Feb 2009 06:11:13 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Peter Gruber <nokos@gmx.net>, Julian Brown <jules@panic.cs-bristol.org.uk>, linux-acpi@vger.kernel.org

Up until now, we polled the rfkill status for every incoming FUJ02E3 ACPI event. 
It turns out that the firmware has a bitmask which indicates what rfkill-related 
state it can report.
The rfkill_supported bitmask is now used to avoid polling for rfkill at all in 
the notification handler if there is no support. Also, it is used in the platform  
device callbacks. As before we register all callbacks and report "unknown" if the 
firmware does not give us status updates for that particular bit.

This was fed through checkpatch.pl and tested on the S6420, S7020 and P8010
platforms.

Signed-off-by: Tony Vroon <tony@linx.net>
Tested-by: Stephen Gildea <stepheng+linux@gildea.com>
Acked-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
--
Len, could we have this in 2.6.29 please. It turns out (based on DSDT analysis) 
that there are platforms that do not implement all 3 status bits and could thus 
report invalid information in one of the 3 platform files.
An example of such a machine would be the Lifebook N6460 which apparently can't 
be docked.

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

