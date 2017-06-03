From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [RFC PATCH] acpi: indicate to platform when hot remove returns busy
Date: Sun,  4 Jun 2017 01:20:36 +0800
Message-ID: <20170603172036.7645-1-jlee@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32855 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdFCRUp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Jun 2017 13:20:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>

In hotplug logic, it always indicates non-specific failure to
platform through _OST when handing acpi hot-remove event failed. Then
platform terminates the hot-remove process but it can not identify
the reason.

Base on current hot-remove code, there have two situations that it
returns busy:
 - OSPM try to offline an individual device, but the device offline
   function returns busy.
 - When the ejection event is applied to an "not offlined yet" container.
   OSPM send kobject change event to userspace and returns busy.

Both of them will returns -EBUSY to acpi device hotplug function then
hotplug function indicates non-specific failure to platform just like
any other error, e.g. -ENODEV or -EIO.

The benefit to platform for identifying the OS busy state is that
platform can be applied different approach to handle the busy but
not just terminate the hot-remove process by unknow reason. For
example, platform can wait for a while then triggers hot-remove
again.

This RFC patch adds one more parameter to the handler function of
acpi generic hotplug event to give the function a chance to propose
the return code of _OST. In this case, it sets ost return code to
ACPI_OST_SC_DEVICE_BUSY when the acpi hot remove function returns
-EBUSY.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/acpi/scan.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2433569..d4aae9f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -374,8 +374,11 @@ static int acpi_scan_bus_check(struct acpi_device *adev)
 	return 0;
 }
 
-static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
+static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type,
+				      u32 *ost_code)
 {
+	int error = -EINVAL;
+
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		return acpi_scan_bus_check(adev);
@@ -389,9 +392,11 @@ static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
 		}
 		acpi_evaluate_ost(adev->handle, ACPI_NOTIFY_EJECT_REQUEST,
 				  ACPI_OST_SC_EJECT_IN_PROGRESS, NULL);
-		return acpi_scan_hot_remove(adev);
+		error = acpi_scan_hot_remove(adev);
+		if (error == -EBUSY && ost_code)
+			*ost_code = ACPI_OST_SC_DEVICE_BUSY;
 	}
-	return -EINVAL;
+	return error;
 }
 
 void acpi_device_hotplug(struct acpi_device *adev, u32 src)
@@ -413,7 +418,7 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
 	if (adev->flags.is_dock_station) {
 		error = dock_notify(adev, src);
 	} else if (adev->flags.hotplug_notify) {
-		error = acpi_generic_hotplug_event(adev, src);
+		error = acpi_generic_hotplug_event(adev, src, &ost_code);
 		if (error == -EPERM) {
 			ost_code = ACPI_OST_SC_EJECT_NOT_SUPPORTED;
 			goto err_out;
-- 
2.10.2

