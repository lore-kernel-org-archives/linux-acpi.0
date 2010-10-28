From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH 1/3] ACPI / PM: Register acpi_power_driver early
Date: Thu, 28 Oct 2010 15:09:12 +0200
Message-ID: <201010281509.12271.rjw@sisk.pl>
References: <201010281507.34994.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33289 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758690Ab0J1NNH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Oct 2010 09:13:07 -0400
In-Reply-To: <201010281507.34994.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

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
---
 drivers/acpi/bus.c  |    1 -
 drivers/acpi/scan.c |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -1025,7 +1025,6 @@ static int __init acpi_init(void)
 
 	acpi_scan_init();
 	acpi_ec_init();
-	acpi_power_init();
 	acpi_sysfs_init();
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -1543,6 +1543,8 @@ int __init acpi_scan_init(void)
 		printk(KERN_ERR PREFIX "Could not register bus type\n");
 	}
 
+	acpi_power_init();
+
 	/*
 	 * Enumerate devices in the ACPI namespace.
 	 */

