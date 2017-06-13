From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH v2] acpi: handle the acpi hotplug schedule error
Date: Tue, 13 Jun 2017 19:11:34 +0800
Message-ID: <20170613111134.13703-1-jlee@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35538 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbdFMLLo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Jun 2017 07:11:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Michal Hocko <mhocko@suse.cz>

Kernel should decrements the reference count of acpi device
when the scheduling of acpi hotplug work is failed, and
evaluates _OST to notify BIOS the failure.

v2:
To simplify the code. (Andy Shevchenko)

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Michal Hocko <mhocko@suse.cz>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/acpi/bus.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 34fbe02..91adb71 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -427,12 +427,17 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
 		driver->ops.notify(adev, type);
 
-	if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
-		return;
+	if (hotplug_event) {
+		if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
+			return;
+		goto err_put_device;
+	}
 
 	acpi_bus_put_acpi_device(adev);
 	return;
 
+ err_put_device:
+	acpi_bus_put_acpi_device(adev);
  err:
 	acpi_evaluate_ost(handle, type, ost_code, NULL);
 }
-- 
2.10.2

