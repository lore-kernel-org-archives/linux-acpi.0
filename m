From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/4] ACPI / bus: Move ACPI bus type registration
Date: Tue, 14 Jul 2015 01:19:46 +0200
Message-ID: <1900858.bRT54aZvGe@vostro.rjw.lan>
References: <4521894.N8pXmo8fxI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45670 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751093AbbGMWxY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2015 18:53:24 -0400
In-Reply-To: <4521894.N8pXmo8fxI@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the registration of the ACPI bus type to acpi_bus_init() and
avoid using ACPI going forward if it fails (too many things depend on
the presence of the ACPI bus type).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/bus.c  |    4 +++-
 drivers/acpi/scan.c |    6 ------
 2 files changed, 3 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/bus.c
===================================================================
--- linux-pm.orig/drivers/acpi/bus.c
+++ linux-pm/drivers/acpi/bus.c
@@ -993,7 +993,9 @@ static int __init acpi_bus_init(void)
 	 */
 	acpi_root_dir = proc_mkdir(ACPI_BUS_FILE_ROOT, NULL);
 
-	return 0;
+	result = bus_register(&acpi_bus_type);
+	if (!result)
+		return 0;
 
 	/* Mimic structured exception handling */
       error1:
Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1932,12 +1932,6 @@ int __init acpi_scan_init(void)
 {
 	int result;
 
-	result = bus_register(&acpi_bus_type);
-	if (result) {
-		/* We don't want to quit even if we failed to add suspend/resume */
-		printk(KERN_ERR PREFIX "Could not register bus type\n");
-	}
-
 	acpi_pci_root_init();
 	acpi_pci_link_init();
 	acpi_processor_init();

