From: Len Brown <lenb@kernel.org>
Subject: [PATCH 38/48] ACPI / PM: Register acpi_power_driver early
Date: Wed, 12 Jan 2011 05:19:32 -0500
Message-ID: <97d9a9e9f5ee68f20005ca5aa77c6b684e7cace8.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab1ALRAh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:37 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:31 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The ACPI device driver used for handling power resources,
acpi_power_driver, creates a struct acpi_power_resource object for
each ACPI device representing a power resource.  These objects are
then used when setting and reading the power states of devices using
the corresponding power resources.  Unfortunately, acpi_power_driver
is registered after acpi_scan_init() that may add devices using the
power resources before acpi_power_driver has a chance to create
struct acpi_power_resource objects for them (specifically, the power
resources may be referred to during the scanning process through
acpi_bus_get_power() before they have been initialized).

As the first step towards fixing this issue, move the registration
of acpi_power_driver into acpi_scan_init() so that power resource
devices can be initialized by it as soon as they have been found in
the namespace.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c  |    1 -
 drivers/acpi/scan.c |    2 ++
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 19decee..4786401 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1099,7 +1099,6 @@ static int __init acpi_init(void)
 
 	acpi_scan_init();
 	acpi_ec_init();
-	acpi_power_init();
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ef8e659..2951a27 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1570,6 +1570,8 @@ int __init acpi_scan_init(void)
 		printk(KERN_ERR PREFIX "Could not register bus type\n");
 	}
 
+	acpi_power_init();
+
 	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */
-- 
1.7.4.rc1.7.g2cf08

