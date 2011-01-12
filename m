From: Len Brown <lenb@kernel.org>
Subject: [PATCH 48/48] ACPI / Battery: Update information on info notification
 and resume
Date: Wed, 12 Jan 2011 05:19:42 -0500
Message-ID: <da8aeb92d4853f37e281f11fddf61f9c7d84c3cd.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab1ALRAi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:38 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:35 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

A notification event 0x81 from an ACPI battery device requires us to
re-read the battery information structure.  Follow this requirement
and remove and re-create the battery's attibutes in sysfs so that
they reflect the reporting units used by the battery at the moment
(those units may actually change sometimes at run time, which happens
on some Thinkpads).

The approach used in this patch was suggested by Matthew Garrett.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Reported-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 2a31421..68bc227 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -631,6 +631,17 @@ static int acpi_battery_update(struct acpi_battery *battery)
 	return result;
 }
 
+static void acpi_battery_refresh(struct acpi_battery *battery)
+{
+	if (!battery->bat.dev)
+		return;
+
+	acpi_battery_get_info(battery);
+	/* The battery may have changed its reporting units. */
+	sysfs_remove_battery(battery);
+	sysfs_add_battery(battery);
+}
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -916,6 +927,8 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 	if (!battery)
 		return;
 	old = battery->bat.dev;
+	if (event == ACPI_BATTERY_NOTIFY_INFO)
+		acpi_battery_refresh(battery);
 	acpi_battery_update(battery);
 	acpi_bus_generate_proc_event(device, event,
 				     acpi_battery_present(battery));
@@ -985,6 +998,7 @@ static int acpi_battery_resume(struct acpi_device *device)
 	if (!device)
 		return -EINVAL;
 	battery = acpi_driver_data(device);
+	acpi_battery_refresh(battery);
 	battery->update_time = 0;
 	acpi_battery_update(battery);
 	return 0;
-- 
1.7.4.rc1.7.g2cf08

