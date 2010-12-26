From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/33] ACPI / PM: Add function for device power state
 initialization
Date: Sun, 26 Dec 2010 17:43:29 -0500
Message-ID: <b91d06e64e9480d93ca61398d678c8420585a8e0.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49913 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059Ab0LZWou (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:44:50 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE2004RP4I9GRJ1@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:44:40 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Add function acpi_bus_init_power() for getting the initial power
state of an ACPI device and reference counting its power resources
as appropriate.

Make acpi_bus_get_power_flags() use the new function instead of
acpi_bus_get_power() that updates device->power.state without
reference counting the device's power resources.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |   25 +++++++++++++++++++++++++
 drivers/acpi/internal.h |    1 +
 drivers/acpi/scan.c     |    5 +----
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9657abc..4534510 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -364,6 +364,31 @@ int acpi_bus_set_power(acpi_handle handle, int state)
 
 EXPORT_SYMBOL(acpi_bus_set_power);
 
+
+int acpi_bus_init_power(struct acpi_device *device)
+{
+	int state;
+	int result;
+
+	if (!device)
+		return -EINVAL;
+
+	device->power.state = ACPI_STATE_UNKNOWN;
+
+	result = __acpi_bus_get_power(device, &state);
+	if (result)
+		return result;
+
+	if (device->power.flags.power_resources)
+		result = acpi_power_on_resources(device, state);
+
+	if (!result)
+		device->power.state = state;
+
+	return result;
+}
+
+
 bool acpi_bus_power_manageable(acpi_handle handle)
 {
 	struct acpi_device *device;
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 433a8ee..7493e6c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -44,6 +44,7 @@ int acpi_device_sleep_wake(struct acpi_device *dev,
 int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
 int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
+int acpi_bus_init_power(struct acpi_device *device);
 extern int acpi_power_nocheck;
 
 int acpi_wakeup_device_init(void);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 2b6c21d..ba9e70d 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -881,10 +881,7 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 	device->power.states[ACPI_STATE_D3].flags.valid = 1;
 	device->power.states[ACPI_STATE_D3].power = 0;
 
-	/* TBD: System wake support and resource requirements. */
-
-	device->power.state = ACPI_STATE_UNKNOWN;
-	acpi_bus_get_power(device->handle, &(device->power.state));
+	acpi_bus_init_power(device);
 
 	return 0;
 }
-- 
1.7.3.3.557.gb5c17

