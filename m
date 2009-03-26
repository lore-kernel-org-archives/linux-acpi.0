From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 06/14] sony-laptop: merge Type4 into Type3
Date: Thu, 26 Mar 2009 21:58:17 +0900
Message-ID: <1238072305-8085-7-git-send-email-malattia@linux.it>
References: <1238072305-8085-1-git-send-email-malattia@linux.it>
 <1238072305-8085-2-git-send-email-malattia@linux.it>
 <1238072305-8085-3-git-send-email-malattia@linux.it>
 <1238072305-8085-4-git-send-email-malattia@linux.it>
 <1238072305-8085-5-git-send-email-malattia@linux.it>
 <1238072305-8085-6-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:53418
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688AbZCZM6a (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 08:58:30 -0400
In-Reply-To: <1238072305-8085-6-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Creating Type4 was a mistake in the first place. Some users report that
also Type3 vaios require the same extra hotkey handling which the Type4
for was menat to guard from.
Merging down Type4 into Type3 will just remove a useless distinction.

Signed-off-by: Mattia Dongili <malattia@linux.it>
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
1.6.2

