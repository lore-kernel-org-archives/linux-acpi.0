From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/48] ACPI / PM: Drop special ACPI wakeup flags
Date: Wed, 12 Jan 2011 05:19:16 -0500
Message-ID: <7fa69baf29de8c77a6b32c054df2abb8f11f8aa4.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab1ALRAi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:38 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:32 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Drop special ACPI wakeup flags, wakeup.state.enabled and
wakeup.flags.always_enabled, that aren't necessary any more after
we've started to use standard device wakeup flags for handling ACPI
wakeup devices.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/glue.c     |    5 +----
 include/acpi/acpi_bus.h |    6 ------
 2 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 78b0164..7c47ed5 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -167,11 +167,8 @@ static int acpi_bind_one(struct device *dev, acpi_handle handle)
 				"firmware_node");
 		ret = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
 				"physical_node");
-		if (acpi_dev->wakeup.flags.valid) {
+		if (acpi_dev->wakeup.flags.valid)
 			device_set_wakeup_capable(dev, true);
-			device_set_wakeup_enable(dev,
-						acpi_dev->wakeup.state.enabled);
-		}
 	}
 
 	return 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 359ef11..f2499f5 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -242,20 +242,14 @@ struct acpi_device_perf {
 struct acpi_device_wakeup_flags {
 	u8 valid:1;		/* Can successfully enable wakeup? */
 	u8 run_wake:1;		/* Run-Wake GPE devices */
-	u8 always_enabled:1;	/* Run-wake devices that are always enabled */
 	u8 notifier_present:1;  /* Wake-up notify handler has been installed */
 };
 
-struct acpi_device_wakeup_state {
-	u8 enabled:1;
-};
-
 struct acpi_device_wakeup {
 	acpi_handle gpe_device;
 	u64 gpe_number;
 	u64 sleep_state;
 	struct acpi_handle_list resources;
-	struct acpi_device_wakeup_state state;
 	struct acpi_device_wakeup_flags flags;
 	int prepare_count;
 	int run_wake_count;
-- 
1.7.4.rc1.7.g2cf08

