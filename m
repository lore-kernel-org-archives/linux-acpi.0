From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/33] ACPI / PM: Introduce __acpi_bus_get_power()
Date: Sun, 26 Dec 2010 17:43:28 -0500
Message-ID: <075fe9382fab4d927992c7dd0fcf47275d22d219.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61195 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab0LZWoi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:44:38 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200EK34I62PN1@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:44:37 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

It sometimes is necessary to get the power state of an ACPI device
without updating its device->power.state field, for example to
avoid inconsistencies between device->power.state and the reference
counters of the device's power resources.  For this purpose introduce
__acpi_bus_get_power() that will return the given device's power
state via a pointer (instead of modifying device->power.state)
and make acpi_bus_get_power() use it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |   48 +++++++++++++++++++++++++++++-------------------
 1 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a9fe8e6..9657abc 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -196,34 +196,24 @@ EXPORT_SYMBOL(acpi_bus_get_private_data);
                                  Power Management
    -------------------------------------------------------------------------- */
 
-int acpi_bus_get_power(acpi_handle handle, int *state)
+static int __acpi_bus_get_power(struct acpi_device *device, int *state)
 {
 	int result = 0;
 	acpi_status status = 0;
-	struct acpi_device *device = NULL;
 	unsigned long long psc = 0;
 
-
-	result = acpi_bus_get_device(handle, &device);
-	if (result)
-		return result;
+	if (!device || !state)
+		return -EINVAL;
 
 	*state = ACPI_STATE_UNKNOWN;
 
-	if (!device->flags.power_manageable) {
-		/* TBD: Non-recursive algorithm for walking up hierarchy */
-		if (device->parent)
-			*state = device->parent->power.state;
-		else
-			*state = ACPI_STATE_D0;
-	} else {
+	if (device->flags.power_manageable) {
 		/*
 		 * Get the device's power state either directly (via _PSC) or
 		 * indirectly (via power resources).
 		 */
 		if (device->power.flags.power_resources) {
-			result = acpi_power_get_inferred_state(device,
-							&device->power.state);
+			result = acpi_power_get_inferred_state(device, state);
 			if (result)
 				return result;
 		} else if (device->power.flags.explicit_get) {
@@ -231,20 +221,40 @@ int acpi_bus_get_power(acpi_handle handle, int *state)
 						       NULL, &psc);
 			if (ACPI_FAILURE(status))
 				return -ENODEV;
-			device->power.state = (int)psc;
+			*state = (int)psc;
 		}
-
-		*state = device->power.state;
+	} else {
+		/* TBD: Non-recursive algorithm for walking up hierarchy. */
+		*state = device->parent ?
+			device->parent->power.state : ACPI_STATE_D0;
 	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] power state is D%d\n",
-			  device->pnp.bus_id, device->power.state));
+			  device->pnp.bus_id, *state));
 
 	return 0;
 }
 
+
+int acpi_bus_get_power(acpi_handle handle, int *state)
+{
+	struct acpi_device *device;
+	int result;
+
+	result = acpi_bus_get_device(handle, &device);
+	if (result)
+		return result;
+
+	result = __acpi_bus_get_power(device, state);
+	if (result)
+		return result;
+
+	device->power.state = *state;
+	return 0;
+}
 EXPORT_SYMBOL(acpi_bus_get_power);
 
+
 int acpi_bus_set_power(acpi_handle handle, int state)
 {
 	int result = 0;
-- 
1.7.3.3.557.gb5c17

