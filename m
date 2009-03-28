From: Len Brown <lenb@kernel.org>
Subject: [PATCH 60/98] sony-laptop: merge Type4 into Type3
Date: Sat, 28 Mar 2009 00:31:35 -0400
Message-ID: <e93c8a6819b217f4f4a490f67f26e02ff6b23b44.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64785 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbZC1EdX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:23 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH70050B8NKEX00@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:21 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Creating Type4 was a mistake in the first place. Some users report that
also Type3 vaios require the same extra hotkey handling which the Type4
for was menat to guard from.
Merging down Type4 into Type3 will just remove a useless distinction.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |   28 ++++++----------------------
 1 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index e000c9f..3e45c65 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1423,7 +1423,6 @@ static struct acpi_driver sony_nc_driver = {
 #define SONYPI_TYPE1_OFFSET	0x04
 #define SONYPI_TYPE2_OFFSET	0x12
 #define SONYPI_TYPE3_OFFSET	0x12
-#define SONYPI_TYPE4_OFFSET	0x12
 
 struct sony_pic_ioport {
 	struct acpi_resource_io	io1;
@@ -1666,14 +1665,6 @@ static struct sonypi_eventtypes type3_events[] = {
 	{ 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
 	{ 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
 	{ 0x31, SONYPI_PKEY_MASK, sonypi_pkeyev },
-	{ 0 },
-};
-static struct sonypi_eventtypes type4_events[] = {
-	{ 0, 0xffffffff, sonypi_releaseev },
-	{ 0x21, SONYPI_FNKEY_MASK, sonypi_fnkeyev },
-	{ 0x31, SONYPI_WIRELESS_MASK, sonypi_wlessev },
-	{ 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
-	{ 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
 	{ 0x05, SONYPI_PKEY_MASK, sonypi_pkeyev },
 	{ 0x05, SONYPI_ZOOM_MASK, sonypi_zoomev },
 	{ 0x05, SONYPI_CAPTURE_MASK, sonypi_captureev },
@@ -1739,11 +1730,11 @@ static u8 sony_pic_call3(u8 dev, u8 fn, u8 v)
 /*
  * minidrivers for SPIC models
  */
-static int type4_handle_irq(const u8 data_mask, const u8 ev)
+static int type3_handle_irq(const u8 data_mask, const u8 ev)
 {
 	/*
 	 * 0x31 could mean we have to take some extra action and wait for
-	 * the next irq for some Type4 models, it will generate a new
+	 * the next irq for some Type3 models, it will generate a new
 	 * irq and we can read new data from the device:
 	 *  - 0x5c and 0x5f requires 0xA0
 	 *  - 0x61 requires 0xB3
@@ -1773,16 +1764,10 @@ static struct device_ctrl spic_types[] = {
 	},
 	{
 		.model = SONYPI_DEVICE_TYPE3,
-		.handle_irq = NULL,
+		.handle_irq = type3_handle_irq,
 		.evport_offset = SONYPI_TYPE3_OFFSET,
 		.event_types = type3_events,
 	},
-	{
-		.model = SONYPI_DEVICE_TYPE4,
-		.handle_irq = type4_handle_irq,
-		.evport_offset = SONYPI_TYPE4_OFFSET,
-		.event_types = type4_events,
-	},
 };
 
 static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
@@ -1806,14 +1791,14 @@ static void sony_pic_detect_device_type(struct sony_pic_dev *dev)
 	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 			PCI_DEVICE_ID_INTEL_ICH7_1, NULL);
 	if (pcidev) {
-		dev->control = &spic_types[3];
+		dev->control = &spic_types[2];
 		goto out;
 	}
 
 	pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
 			PCI_DEVICE_ID_INTEL_ICH8_4, NULL);
 	if (pcidev) {
-		dev->control = &spic_types[3];
+		dev->control = &spic_types[2];
 		goto out;
 	}
 
@@ -1826,8 +1811,7 @@ out:
 
 	printk(KERN_INFO DRV_PFX "detected Type%d model\n",
 			dev->control->model == SONYPI_DEVICE_TYPE1 ? 1 :
-			dev->control->model == SONYPI_DEVICE_TYPE2 ? 2 :
-			dev->control->model == SONYPI_DEVICE_TYPE3 ? 3 : 4);
+			dev->control->model == SONYPI_DEVICE_TYPE2 ? 2 : 3);
 }
 
 /* camera tests and poweron/poweroff */
-- 
1.6.0.6

