From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/33] ACPI / PM: Register acpi_power_driver early
Date: Sun, 26 Dec 2010 17:43:31 -0500
Message-ID: <621210b6cb252cf8d34d2c4adad6e800ad3928d7.1293403342.git.len.brown@intel.com>
References: <1293403434-12054-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:51668 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab0LZW6s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 26 Dec 2010 17:58:48 -0500
Received: from localhost.localdomain ([unknown] [108.7.186.163])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LE200DX055VNMD4@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 26 Dec 2010 16:58:47 -0600 (CST)
In-reply-to: <1293403434-12054-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1293403342.git.len.brown@intel.com>
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
index ba9e70d..06b5f29 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1547,6 +1547,8 @@ int __init acpi_scan_init(void)
 		printk(KERN_ERR PREFIX "Could not register bus type\n");
 	}
 
+	acpi_power_init();
+
 	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */
-- 
1.7.3.3.557.gb5c17

