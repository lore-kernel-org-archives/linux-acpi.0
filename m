From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/48] ACPI / PM: Prevent acpi_power_get_inferred_state() from
 making changes
Date: Wed, 12 Jan 2011 05:19:26 -0500
Message-ID: <32a00d274e877eab3ea7ab196b75c9be5170d25e.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49136 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434Ab1ALSAR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:17 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:17 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

acpi_power_get_inferred_state() should not update
device->power.state behind the back of its caller, so make it return
the state via a pointer instead.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c      |    3 ++-
 drivers/acpi/internal.h |    2 +-
 drivers/acpi/power.c    |   12 ++++--------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index d68bd61..a9fe8e6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -222,7 +222,8 @@ int acpi_bus_get_power(acpi_handle handle, int *state)
 		 * indirectly (via power resources).
 		 */
 		if (device->power.flags.power_resources) {
-			result = acpi_power_get_inferred_state(device);
+			result = acpi_power_get_inferred_state(device,
+							&device->power.state);
 			if (result)
 				return result;
 		} else if (device->power.flags.explicit_get) {
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index a212bfe..2cc0148 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -41,7 +41,7 @@ static inline int acpi_debugfs_init(void) { return 0; }
 int acpi_power_init(void);
 int acpi_device_sleep_wake(struct acpi_device *dev,
                            int enable, int sleep_state, int dev_state);
-int acpi_power_get_inferred_state(struct acpi_device *device);
+int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
 int acpi_power_transition(struct acpi_device *device, int state);
 extern int acpi_power_nocheck;
 
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 4c9c2fb..9bd1b60 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -423,19 +423,16 @@ int acpi_disable_wakeup_device_power(struct acpi_device *dev)
                              Device Power Management
    -------------------------------------------------------------------------- */
 
-int acpi_power_get_inferred_state(struct acpi_device *device)
+int acpi_power_get_inferred_state(struct acpi_device *device, int *state)
 {
 	int result = 0;
 	struct acpi_handle_list *list = NULL;
 	int list_state = 0;
 	int i = 0;
 
-
-	if (!device)
+	if (!device || !state)
 		return -EINVAL;
 
-	device->power.state = ACPI_STATE_UNKNOWN;
-
 	/*
 	 * We know a device's inferred power state when all the resources
 	 * required for a given D-state are 'on'.
@@ -450,13 +447,12 @@ int acpi_power_get_inferred_state(struct acpi_device *device)
 			return result;
 
 		if (list_state == ACPI_POWER_RESOURCE_STATE_ON) {
-			device->power.state = i;
+			*state = i;
 			return 0;
 		}
 	}
 
-	device->power.state = ACPI_STATE_D3;
-
+	*state = ACPI_STATE_D3;
 	return 0;
 }
 
-- 
1.7.4.rc1.7.g2cf08

