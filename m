From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH v2 resend] ACPI: generate wakeup events on fixed power button
Date: Thu, 10 May 2012 00:08:43 +0100 (BST)
Message-ID: <20120509230843.C3EF79D401E@zog.reactivated.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:25725 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757590Ab2EIXIs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 May 2012 19:08:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, pgf@laptop.org, rui.zhang@intel.com

When the system is woken up by the ACPI fixed power button, currently there
is no way of userspace becoming aware that the power button was pressed.

OLPC would like to know this, so that we can respond appropriately.
For example, if the system was woken up by a network packet, we know
we can go back to sleep very quickly. But if the user explicitly woke the
system with the power button, we're going to want to stay awake for a
while.

The wakeup count mechanism seems like a good fit for communicating this.
Mark the fixed power button as wakeup-enabled, and increment its wakeup
counter when the system is woken with the power button. (The wakeup counter
is also incremented when the power button is pressed during system
operation; this is already handled by an existing acpi-button codepath).

Signed-off-by: Daniel Drake <dsd@laptop.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/scan.c  |    1 +
 drivers/acpi/sleep.c |   45 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

v2: add missing put_device() call
Resending after 3 weeks with no response.

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7417267..06d2135 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1563,6 +1563,7 @@ static int acpi_bus_scan_fixed(void)
 						ACPI_BUS_TYPE_POWER_BUTTON,
 						ACPI_STA_DEFAULT,
 						&ops);
+		device_init_wakeup(&device->dev, true);
 	}
 
 	if ((acpi_gbl_FADT.flags & ACPI_FADT_SLEEP_BUTTON) == 0) {
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index eb6fd23..a564fc3 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -57,6 +57,7 @@ MODULE_PARM_DESC(gts, "Enable evaluation of _GTS on suspend.");
 MODULE_PARM_DESC(bfs, "Enable evaluation of _BFS on resume".);
 
 static u8 sleep_states[ACPI_S_STATE_COUNT];
+static bool pwr_btn_event_pending;
 
 static void acpi_sleep_tts_switch(u32 acpi_state)
 {
@@ -186,6 +187,14 @@ static int acpi_pm_prepare(void)
 	return error;
 }
 
+static int find_powerf_dev(struct device *dev, void *data)
+{
+	struct acpi_device *device = to_acpi_device(dev);
+	const char *hid = acpi_device_hid(device);
+
+	return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
+}
+
 /**
  *	acpi_pm_finish - Instruct the platform to leave a sleep state.
  *
@@ -194,6 +203,7 @@ static int acpi_pm_prepare(void)
  */
 static void acpi_pm_finish(void)
 {
+	struct device *pwr_btn_dev;
 	u32 acpi_state = acpi_target_sleep_state;
 
 	acpi_ec_unblock_transactions();
@@ -211,6 +221,23 @@ static void acpi_pm_finish(void)
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
 	acpi_target_sleep_state = ACPI_STATE_S0;
+
+	/* If we were woken with the fixed power button, provide a small
+	 * hint to userspace in the form of a wakeup event on the fixed power
+	 * button device (if it can be found).
+	 *
+	 * We delay the event generation til now, as the PM layer requires
+	 * timekeeping to be running before we generate events. */
+	if (!pwr_btn_event_pending)
+		return;
+
+	pwr_btn_event_pending = false;
+	pwr_btn_dev = bus_find_device(&acpi_bus_type, NULL, NULL,
+				      find_powerf_dev);
+	if (pwr_btn_dev) {
+		pm_wakeup_event(pwr_btn_dev, 0);
+		put_device(pwr_btn_dev);
+	}
 }
 
 /**
@@ -300,9 +327,23 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	/* ACPI 3.0 specs (P62) says that it's the responsibility
 	 * of the OSPM to clear the status bit [ implying that the
 	 * POWER_BUTTON event should not reach userspace ]
+	 *
+	 * However, we do generate a small hint for userspace in the form of
+	 * a wakeup event. We flag this condition for now and generate the
+	 * event later, as we're currently too early in resume to be able to
+	 * generate wakeup events.
 	 */
-	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3))
-		acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
+	if (ACPI_SUCCESS(status) && (acpi_state == ACPI_STATE_S3)) {
+		acpi_event_status pwr_btn_status;
+
+		acpi_get_event_status(ACPI_EVENT_POWER_BUTTON, &pwr_btn_status);
+
+		if (pwr_btn_status & ACPI_EVENT_FLAG_SET) {
+			acpi_clear_event(ACPI_EVENT_POWER_BUTTON);
+			/* Flag for later */
+			pwr_btn_event_pending = true;
+		}
+	}
 
 	/*
 	 * Disable and clear GPE status before interrupt is enabled. Some GPEs
-- 
1.7.10

