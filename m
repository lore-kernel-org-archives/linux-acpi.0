From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH] acpi: handle the acpi hotplug schedule error
Date: Sat,  3 Jun 2017 15:38:58 +0800
Message-ID: <20170603073858.2332-1-jlee@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34470 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbdFCHjK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Jun 2017 03:39:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>

Kernel should the decrement reference count of acpi device when
acpi hotplug work scheduling is failed. And, kernel should evaluates
_OST to notify BIOS the failure.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/acpi/bus.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 34fbe02..2f2cec9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -427,8 +427,14 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
 		driver->ops.notify(adev, type);
 
-	if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
-		return;
+	if (hotplug_event) {
+		if (ACPI_FAILURE(acpi_hotplug_schedule(adev, type))) {
+			acpi_bus_put_acpi_device(adev);
+			goto err;
+		} else {
+			return;
+		}
+	}
 
 	acpi_bus_put_acpi_device(adev);
 	return;
-- 
2.10.2

