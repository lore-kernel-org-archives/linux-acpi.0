From: Len Brown <len.brown@intel.com>
Subject: [PATCH 67/77] sony-laptop: Invoke _INI for SNC devices that provide it
Date: Sun, 22 Jul 2007 05:14:52 -0400
Message-ID: <11850957721285-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
 <11850957571080-git-send-email-len.brown@intel.com>
 <11850957591101-git-send-email-len.brown@intel.com>
 <11850957601664-git-send-email-len.brown@intel.com>
 <1185095761326-git-send-email-len.brown@intel.com>
 <11850957621605-git-send-email-len.brown@intel.com>
 <11850957633613-git-send-email-len.brown@intel.com>
 <11850957641697-git-send-email-len.brown@intel.com>
 <11850957651127-git-send-email-len.brown@intel.com>
 <1185095766274-git-send-email-len.brown@intel.com>
 <1185095767879-git-send-email-len.brown@intel.com>
 <1185095768376-git-send-email-len.brown@intel.com>
 <11850957691561-git-send-email-len.brown@intel.com>
 <11850957703097-git-send-email-len.brown@intel.com>
 <11850957712166-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6024 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764406AbXGVJQQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:16 -0400
In-Reply-To: <11850957712166-git-send-email-len.brown@intel.com>
Message-Id: <b25b732a16e4e035247fa729f931ed173f9fc8e2.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 43315be..5300cad 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -864,6 +864,15 @@ static int sony_nc_add(struct acpi_device *device)
 
 	sony_nc_acpi_handle = device->handle;
 
+	/* read device status */
+	result = acpi_bus_get_status(device);
+	/* bail IFF the above call was successful and the device is not present */
+	if (!result && !device->status.present) {
+		dprintk("Device not present\n");
+		result = -ENODEV;
+		goto outwalk;
+	}
+
 	if (debug) {
 		status = acpi_walk_namespace(ACPI_TYPE_METHOD, sony_nc_acpi_handle,
 					     1, sony_walk_callback, NULL, NULL);
@@ -874,6 +883,15 @@ static int sony_nc_add(struct acpi_device *device)
 		}
 	}
 
+	/* try to _INI the device if such method exists (ACPI spec 3.0-6.5.1
+	 * should be respected as we already checked for the device presence above */
+	if (ACPI_SUCCESS(acpi_get_handle(sony_nc_acpi_handle, METHOD_NAME__INI, &handle))) {
+		dprintk("Invoking _INI\n");
+		if (ACPI_FAILURE(acpi_evaluate_object(sony_nc_acpi_handle, METHOD_NAME__INI,
+						NULL, NULL)))
+			dprintk("_INI Method failed\n");
+	}
+
 	/* setup input devices and helper fifo */
 	result = sony_laptop_setup_input();
 	if (result) {
@@ -886,7 +904,7 @@ static int sony_nc_add(struct acpi_device *device)
 					     ACPI_DEVICE_NOTIFY,
 					     sony_acpi_notify, NULL);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_WARNING DRV_PFX "unable to install notify handler\n");
+		printk(KERN_WARNING DRV_PFX "unable to install notify handler (%u)\n", status);
 		result = -ENODEV;
 		goto outinput;
 	}
-- 
1.5.3.rc2.22.g69a9b
