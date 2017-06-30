From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH v3] acpi: handle the acpi hotplug schedule error
Date: Fri, 30 Jun 2017 15:25:38 +0800
Message-ID: <20170630072538.12910-1-jlee@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33361 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdF3H0A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jun 2017 03:26:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Michal Hocko <mhocko@suse.cz>

Kernel should decrements the reference count of acpi device
when the scheduling of acpi hotplug work failed, and evaluates
_OST to notify BIOS the failure.

v3:
More simplify the code. (Rafael J. Wysocki)

v2:
To simplify the code. (Andy Shevchenko)

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Michal Hocko <mhocko@suse.cz>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/acpi/bus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 784bda6..9d4fea6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -432,11 +432,15 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	    (driver->flags & ACPI_DRIVER_ALL_NOTIFY_EVENTS))
 		driver->ops.notify(adev, type);
 
-	if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
+	if (!hotplug_event) {
+		acpi_bus_put_acpi_device(adev);
+		return;
+	}
+
+	if (ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
 		return;
 
 	acpi_bus_put_acpi_device(adev);
-	return;
 
  err:
 	acpi_evaluate_ost(handle, type, ost_code, NULL);
-- 
2.10.2

