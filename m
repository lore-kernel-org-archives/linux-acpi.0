From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] ACPI / scan: No implicit wake notification for buttons
Date: Mon, 14 Jul 2014 22:41:41 +0200
Message-ID: <1958153.C2cDldxl98@vostro.rjw.lan>
References: <7323172.bFe2jdDKx7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49579 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756540AbaGNUXc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jul 2014 16:23:32 -0400
In-Reply-To: <7323172.bFe2jdDKx7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Lan Tianyu <tianyu.lan@intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI device enumeration code in Linux assumes that buttons always
are wakeup devices, so it calls acpi_setup_gpe_for_wake() for them
which leads to undesirable side effects.  Namely, that function sets
up implicit device wake notification mechanism for a given GPE if
there is no handler method in the ACPI namespace, which from the
ACPICA's perspective means that there always is a way to handle
that GPE if enabled.  However, we don't handle wake notify events
for buttons, so if there are no handler methods for their GPEs in
the namespace, enabling a button GPE at run time leads to a GPE
storm in some cases (the GPE triggers, ACPICA carries out the
implicit wake notification for it which isn't handled, so the
GPE triggers again and so on).

To prevent that from happening use acpi_mark_gpe_for_wake()
instead of acpi_setup_gpe_for_wake() for buttons which will cause
ACPICA to only enable button GPEs if there are handler methods for
the in the namespace.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1423,14 +1423,13 @@ static int acpi_bus_extract_wakeup_devic
 			wakeup->sleep_state = sleep_state;
 		}
 	}
-	acpi_setup_gpe_for_wake(handle, wakeup->gpe_device, wakeup->gpe_number);
 
  out:
 	kfree(buffer.pointer);
 	return err;
 }
 
-static void acpi_bus_set_run_wake_flags(struct acpi_device *device)
+static void acpi_wakeup_gpe_init(struct acpi_device *device)
 {
 	struct acpi_device_id button_device_ids[] = {
 		{"PNP0C0C", 0},
@@ -1438,29 +1437,33 @@ static void acpi_bus_set_run_wake_flags(
 		{"PNP0C0E", 0},
 		{"", 0},
 	};
+	struct acpi_device_wakeup *wakeup = &device->wakeup;
 	acpi_status status;
 	acpi_event_status event_status;
 
-	device->wakeup.flags.notifier_present = 0;
+	wakeup->flags.notifier_present = 0;
 
 	/* Power button, Lid switch always enable wakeup */
 	if (!acpi_match_device_ids(device, button_device_ids)) {
-		device->wakeup.flags.run_wake = 1;
+		wakeup->flags.run_wake = 1;
 		if (!acpi_match_device_ids(device, &button_device_ids[1])) {
 			/* Do not use Lid/sleep button for S5 wakeup */
-			if (device->wakeup.sleep_state == ACPI_STATE_S5)
-				device->wakeup.sleep_state = ACPI_STATE_S4;
+			if (wakeup->sleep_state == ACPI_STATE_S5)
+				wakeup->sleep_state = ACPI_STATE_S4;
 		}
+		acpi_mark_gpe_for_wake(wakeup->gpe_device, wakeup->gpe_number);
 		device_set_wakeup_capable(&device->dev, true);
 		return;
 	}
 
-	status = acpi_get_gpe_status(device->wakeup.gpe_device,
-					device->wakeup.gpe_number,
-						&event_status);
-	if (status == AE_OK)
-		device->wakeup.flags.run_wake =
-				!!(event_status & ACPI_EVENT_FLAG_HANDLE);
+	acpi_setup_gpe_for_wake(device->handle, wakeup->gpe_device,
+				wakeup->gpe_number);
+	status = acpi_get_gpe_status(wakeup->gpe_device, wakeup->gpe_number,
+				     &event_status);
+	if (ACPI_FAILURE(status))
+		return;
+
+	wakeup->flags.run_wake = !!(event_status & ACPI_EVENT_FLAG_HANDLE);
 }
 
 static void acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
@@ -1480,7 +1483,7 @@ static void acpi_bus_get_wakeup_device_f
 
 	device->wakeup.flags.valid = 1;
 	device->wakeup.prepare_count = 0;
-	acpi_bus_set_run_wake_flags(device);
+	acpi_wakeup_gpe_init(device);
 	/* Call _PSW/_DSW object to disable its ability to wake the sleeping
 	 * system for the ACPI device with the _PRW object.
 	 * The _PSW object is depreciated in ACPI 3.0 and is replaced by _DSW.

