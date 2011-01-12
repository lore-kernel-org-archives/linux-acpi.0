From: Len Brown <lenb@kernel.org>
Subject: [PATCH 47/48] ACPI: Drop device flag wake_capable
Date: Wed, 12 Jan 2011 05:19:41 -0500
Message-ID: <d57d09a480e1db38eeee7629c81289b00f338a15.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49185 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab1ALSAU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:20 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:20 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

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
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c     |   26 +++++++++-----------------
 include/acpi/acpi_bus.h |    3 +--
 2 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b5e4ded..b99e624 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -815,16 +815,22 @@ static void acpi_bus_set_run_wake_flags(struct acpi_device *device)
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
@@ -840,11 +846,6 @@ static int acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
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
@@ -950,11 +951,6 @@ static int acpi_bus_get_flags(struct acpi_device *device)
 	if (ACPI_SUCCESS(status))
 		device->flags.power_manageable = 1;
 
-	/* Presence of _PRW indicates wake capable */
-	status = acpi_get_handle(device->handle, "_PRW", &temp);
-	if (ACPI_SUCCESS(status))
-		device->flags.wake_capable = 1;
-
 	/* TBD: Performance management */
 
 	return 0;
@@ -1281,11 +1277,7 @@ static int acpi_add_single_object(struct acpi_device **child,
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
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 20b05cd..78ca429 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -148,8 +148,7 @@ struct acpi_device_flags {
 	u32 suprise_removal_ok:1;
 	u32 power_manageable:1;
 	u32 performance_manageable:1;
-	u32 wake_capable:1;	/* Wakeup(_PRW) supported? */
-	u32 reserved:23;
+	u32 reserved:24;
 };
 
 /* File System */
-- 
1.7.4.rc1.7.g2cf08

