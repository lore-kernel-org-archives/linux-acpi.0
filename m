From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 10/11] ACPI: Drop device flag wake_capable
Date: Thu, 6 Jan 2011 23:41:27 +0100
Message-ID: <201101062341.27705.rjw@sisk.pl>
References: <201101062331.17079.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201101062331.17079.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The wake_capable ACPI device flag is not necessary, because it is
only used in scan.c for recording the information that _PRW is
present for the given device.  That information is only used by
acpi_add_single_object() to decide whether or not to call
acpi_bus_get_wakeup_device_flags(), so the flag may be dropped
if the _PRW check is moved to acpi_bus_get_wakeup_device_flags().
Moreover, acpi_bus_get_wakeup_device_flags() always returns 0,
so it really should be void.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/scan.c     |   26 +++++++++-----------------
 include/acpi/acpi_bus.h |    3 +--
 2 files changed, 10 insertions(+), 19 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -815,16 +815,22 @@ static void acpi_bus_set_run_wake_flags(
 				!!(event_status & ACPI_EVENT_FLAG_HANDLE);
 }
 
-static int acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
+static void acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 {
+	acpi_handle temp;
 	acpi_status status = 0;
 	int psw_error;
 
+	/* Presence of _PRW indicates wake capable */
+	status = acpi_get_handle(device->handle, "_PRW", &temp);
+	if (ACPI_FAILURE(status))
+		return;
+
 	status = acpi_bus_extract_wakeup_device_power_package(device->handle,
 							      &device->wakeup);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Extracting _PRW package"));
-		goto end;
+		return;
 	}
 
 	device->wakeup.flags.valid = 1;
@@ -840,11 +846,6 @@ static int acpi_bus_get_wakeup_device_fl
 	if (psw_error)
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				"error in _DSW or _PSW evaluation\n"));
-
-end:
-	if (ACPI_FAILURE(status))
-		device->flags.wake_capable = 0;
-	return 0;
 }
 
 static void acpi_bus_add_power_resource(acpi_handle handle);
@@ -950,11 +951,6 @@ static int acpi_bus_get_flags(struct acp
 	if (ACPI_SUCCESS(status))
 		device->flags.power_manageable = 1;
 
-	/* Presence of _PRW indicates wake capable */
-	status = acpi_get_handle(device->handle, "_PRW", &temp);
-	if (ACPI_SUCCESS(status))
-		device->flags.wake_capable = 1;
-
 	/* TBD: Performance management */
 
 	return 0;
@@ -1281,11 +1277,7 @@ static int acpi_add_single_object(struct
 	 * Wakeup device management
 	 *-----------------------
 	 */
-	if (device->flags.wake_capable) {
-		result = acpi_bus_get_wakeup_device_flags(device);
-		if (result)
-			goto end;
-	}
+	acpi_bus_get_wakeup_device_flags(device);
 
 	/*
 	 * Performance Management
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -148,8 +148,7 @@ struct acpi_device_flags {
 	u32 suprise_removal_ok:1;
 	u32 power_manageable:1;
 	u32 performance_manageable:1;
-	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
-	u32 reserved:23;
+	u32 reserved:24;
 };
 
 /* File System */
