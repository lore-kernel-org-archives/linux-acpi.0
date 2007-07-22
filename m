From: Len Brown <len.brown@intel.com>
Subject: [PATCH 66/77] sony-laptop: Add support for recent Vaios Fn keys (C series for now)
Date: Sun, 22 Jul 2007 05:14:51 -0400
Message-ID: <11850957712166-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45627 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764423AbXGVJQN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:13 -0400
In-Reply-To: <11850957703097-git-send-email-len.brown@intel.com>
Message-Id: <6315fd1c9cd6870a253699f07c5ada85cfe8fecb.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

Recent Vaios (C, AR, N, FE) need some special initialization
sequence to enable Fn keys interrupts through the Embedded
Controller. Moreover Fn keys have to be decoded internally
using ACPI methods to get the key code.
Thus a new DMI table to add SNC init time callbacks and new
mappings for model-specific key code to generic sony-laptop
code have been added.

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |  107 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 142d660..43315be 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -705,13 +705,107 @@ static struct backlight_ops sony_backlight_ops = {
 };
 
 /*
+ * New SNC-only Vaios event mapping to driver known keys
+ */
+struct sony_nc_event {
+	u8	data;
+	u8	event;
+};
+
+static struct sony_nc_event *sony_nc_events;
+
+/* Vaio C* --maybe also FE*, N* and AR* ?-- special init sequence
+ * for Fn keys
+ */
+static int sony_nc_C_enable(struct dmi_system_id *id)
+{
+	int result = 0;
+
+	printk(KERN_NOTICE DRV_PFX "detected %s\n", id->ident);
+
+	sony_nc_events = id->driver_data;
+
+	if (acpi_callsetfunc(sony_nc_acpi_handle, "SN02", 0x4, &result) < 0
+			|| acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x2, &result) < 0
+			|| acpi_callsetfunc(sony_nc_acpi_handle, "SN02", 0x10, &result) < 0
+			|| acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x0, &result) < 0
+			|| acpi_callsetfunc(sony_nc_acpi_handle, "SN03", 0x2, &result) < 0
+			|| acpi_callsetfunc(sony_nc_acpi_handle, "SN07", 0x101, &result) < 0) {
+		printk(KERN_WARNING DRV_PFX "failed to initialize SNC, some "
+				"functionalities may be missing\n");
+		return 1;
+	}
+	return 0;
+}
+
+static struct sony_nc_event sony_C_events[] = {
+	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
+	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x85, SONYPI_EVENT_FNKEY_F5 },
+	{ 0x05, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x86, SONYPI_EVENT_FNKEY_F6 },
+	{ 0x06, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x87, SONYPI_EVENT_FNKEY_F7 },
+	{ 0x07, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x8A, SONYPI_EVENT_FNKEY_F10 },
+	{ 0x0A, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x8C, SONYPI_EVENT_FNKEY_F12 },
+	{ 0x0C, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0, 0 },
+};
+
+/* SNC-only model map */
+struct dmi_system_id sony_nc_ids[] = {
+		{
+			.ident = "Sony Vaio C Series",
+			.callback = sony_nc_C_enable,
+			.driver_data = sony_C_events,
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-C"),
+			},
+		},
+		{ }
+};
+
+/*
  * ACPI callbacks
  */
 static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	dprintk("sony_acpi_notify, event: %d\n", event);
-	sony_laptop_report_input_event(event);
-	acpi_bus_generate_event(sony_nc_acpi_device, 1, event);
+	struct sony_nc_event *evmap;
+	u32 ev = event;
+	int result;
+
+	if (ev == 0x92) {
+		/* read the key pressed from EC.GECR
+		 * A call to SN07 with 0x0202 will do it as well respecting
+		 * the current protocol on different OSes
+		 *
+		 * Note: the path for GECR may be
+		 *   \_SB.PCI0.LPCB.EC (C, FE, AR, N and friends)
+		 *   \_SB.PCI0.PIB.EC0 (VGN-FR notifications are sent directly, no GECR)
+		 *
+		 * TODO: we may want to do the same for the older GHKE -need
+		 *       dmi list- so this snippet may become one more callback.
+		 */
+		if (acpi_callsetfunc(handle, "SN07", 0x0202, &result) < 0)
+			dprintk("sony_acpi_notify, unable to decode event 0x%.2x\n", ev);
+		else
+			ev = result & 0xFF;
+	}
+
+	if (sony_nc_events)
+		for (evmap = sony_nc_events; evmap->event; evmap++) {
+			if (evmap->data == ev) {
+				ev = evmap->event;
+				break;
+			}
+		}
+
+	dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
+	sony_laptop_report_input_event(ev);
+	acpi_bus_generate_event(sony_nc_acpi_device, 1, ev);
 }
 
 static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
@@ -748,6 +842,10 @@ static int sony_nc_resume(struct acpi_device *device)
 			break;
 		}
 	}
+
+	/* re-initialize models with specific requirements */
+	dmi_check_system(sony_nc_ids);
+
 	return 0;
 }
 
@@ -811,6 +909,9 @@ static int sony_nc_add(struct acpi_device *device)
 
 	}
 
+	/* initialize models with specific requirements */
+	dmi_check_system(sony_nc_ids);
+
 	result = sony_pf_add();
 	if (result)
 		goto outbacklight;
-- 
1.5.3.rc2.22.g69a9b
