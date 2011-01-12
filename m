From: Len Brown <lenb@kernel.org>
Subject: [PATCH 34/48] ACPI / PM: Introduce function for refcounting device
 power resources
Date: Wed, 12 Jan 2011 05:19:28 -0500
Message-ID: <30d3df41b32b1ea63d3ebc52ef5644cbe41520f4.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab1ALRAd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:33 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:28 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce function acpi_power_on_resources() that reference counts
and possibly turns on ACPI power resources for a given device and
a given power state of it.

This function will be used for reference counting device power
resources during initialization.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/internal.h |    1 +
 drivers/acpi/power.c    |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 2cc0148..433a8ee 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -42,6 +42,7 @@ int acpi_power_init(void);
 int acpi_device_sleep_wake(struct acpi_device *dev,
                            int enable, int sleep_state, int dev_state);
 int acpi_power_get_inferred_state(struct acpi_device *device, int *state);
+int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
 extern int acpi_power_nocheck;
 
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 95fedbd..0cb4eab 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -485,6 +485,14 @@ int acpi_power_get_inferred_state(struct acpi_device *device, int *state)
 	return 0;
 }
 
+int acpi_power_on_resources(struct acpi_device *device, int state)
+{
+	if (!device || state < ACPI_STATE_D0 || state > ACPI_STATE_D3)
+		return -EINVAL;
+
+	return acpi_power_on_list(&device->power.states[state].resources);
+}
+
 int acpi_power_transition(struct acpi_device *device, int state)
 {
 	int result;
-- 
1.7.4.rc1.7.g2cf08

