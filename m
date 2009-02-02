From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Skip the first two elements in the _BCL package
Date: Mon, 02 Feb 2009 11:33:41 +0800
Message-ID: <1233545621.3715.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24500 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753525AbZBBDWD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Feb 2009 22:22:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI: Skip the first two elements in the _BCL package
From: Zhao Yakui <yakui.zhao@intel.com> 
   According to the Spec the first two elements in the _BCL package won't be
regarded as the available brightness level. The first is the brightness when 
full power is connected to the box(It means that the AC adapter is plugged).
The second is the brightness level when the box is on battery.
    If the first two elements are still used while finding the next brightness
level, it will fall back to the lowest level when keeping on pressing 
hotkey. (On some boxes the brightness will be changed twice when hotkey is
pressed once. One is in the ACPI video driver. The other is changed by sys I/F.
In the ACPI video driver the first two elements will be used while changing
the brightness. But the first two elements is skipped while using sys I/F.
In such case there exists the inconsistency).
    So he first two elements had better be skipped while showing the available
brightness or finding the next brightness level.
     
http://bugzilla.kernel.org/show_bug.cgi?id=12450

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c	2009-01-23 14:47:25.000000000 +0800
+++ linux-2.6/drivers/acpi/video.c	2009-02-02 11:11:55.000000000 +0800
@@ -1020,7 +1020,7 @@
 	}
 
 	seq_printf(seq, "levels: ");
-	for (i = 0; i < dev->brightness->count; i++)
+	for (i = 2; i < dev->brightness->count; i++)
 		seq_printf(seq, " %d", dev->brightness->levels[i]);
 	seq_printf(seq, "\ncurrent: %d\n", dev->brightness->curr);
 
@@ -1059,7 +1059,7 @@
 		return -EFAULT;
 
 	/* validate through the list of available levels */
-	for (i = 0; i < dev->brightness->count; i++)
+	for (i = 2; i < dev->brightness->count; i++)
 		if (level == dev->brightness->levels[i]) {
 			if (ACPI_SUCCESS
 			    (acpi_video_device_lcd_set_level(dev, level)))
@@ -1712,7 +1712,7 @@
 	max = max_below = 0;
 	min = min_above = 255;
 	/* Find closest level to level_current */
-	for (i = 0; i < device->brightness->count; i++) {
+	for (i = 2; i < device->brightness->count; i++) {
 		l = device->brightness->levels[i];
 		if (abs(l - level_current) < abs(delta)) {
 			delta = l - level_current;
@@ -1722,7 +1722,7 @@
 	}
 	/* Ajust level_current to closest available level */
 	level_current += delta;
-	for (i = 0; i < device->brightness->count; i++) {
+	for (i = 2; i < device->brightness->count; i++) {
 		l = device->brightness->levels[i];
 		if (l < min)
 			min = l;


