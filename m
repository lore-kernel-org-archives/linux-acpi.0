From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 3/5] Add support for recent Vaios Fn keys (C series for now)
Date: Wed, 11 Jul 2007 00:04:33 +0900
Message-ID: <11840798753415-git-send-email-malattia@linux.it>
References: <1184079875379-git-send-email-malattia@linux.it>
 <11840798753720-git-send-email-malattia@linux.it>
 <11840798752561-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi13.ns.itscom.net ([219.110.2.183]:38507 "EHLO
	mtoichi13.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543AbXGJPEx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jul 2007 11:04:53 -0400
In-Reply-To: <11840798752561-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Recent Vaios (C, AR, N, FE) need some special initialization
sequence to enable Fn keys interrupts through the Embedded
Controller. Moreover Fn keys have to be decoded internally
using ACPI methods to get the key code.
Thus a new DMI table to add SNC init time callbacks and new
mappings for model-specific key code to generic sony-laptop
code have been added.

Signed-off-by: Mattia Dongili <malattia@linux.it>
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
1.5.2.3

