From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/33] ACPI / PM: Drop acpi_bus_get_power()
Date: Sun, 26 Dec 2010 17:43:36 -0500
Message-ID: <c2e305e8671906c92ee2b8e0d98216a0a7b15c63.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51680 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab0LZW6t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:58:49 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200DX055VNMD4@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:58:48 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

There are no more users of acpi_bus_get_power(), so it can be
dropped.  Moreover, it should be dropped, because it modifies
the device->power.state field of an ACPI device without updating
the reference counters of the device's power resources, which is
wrong.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |   19 -------------------
 include/acpi/acpi_bus.h |    1 -
 2 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 2ee83b5..0baa5f9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -236,25 +236,6 @@ static int __acpi_bus_get_power(struct acpi_device *device, int *state)
 }
 
 
-int acpi_bus_get_power(acpi_handle handle, int *state)
-{
-	struct acpi_device *device;
-	int result;
-
-	result = acpi_bus_get_device(handle, &device);
-	if (result)
-		return result;
-
-	result = __acpi_bus_get_power(device, state);
-	if (result)
-		return result;
-
-	device->power.state = *state;
-	return 0;
-}
-EXPORT_SYMBOL(acpi_bus_get_power);
-
-
 static int __acpi_bus_set_power(struct acpi_device *device, int state)
 {
 	int result = 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 8912580..673a3f4 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -327,7 +327,6 @@ void acpi_bus_data_handler(acpi_handle handle, void *context);
 acpi_status acpi_bus_get_status_handle(acpi_handle handle,
 				       unsigned long long *sta);
 int acpi_bus_get_status(struct acpi_device *device);
-int acpi_bus_get_power(acpi_handle handle, int *state);
 int acpi_bus_set_power(acpi_handle handle, int state);
 int acpi_bus_update_power(acpi_handle handle, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
-- 
1.7.3.3.557.gb5c17

