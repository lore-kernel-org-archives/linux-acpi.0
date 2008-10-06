From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Resend] [PATCH] ACPI: Enable EC device immediately after ACPI
	full initialization
Date: Mon, 06 Oct 2008 10:31:36 +0800
Message-ID: <1223260296.4023.292.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:63473 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbYJFCZ5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Oct 2008 22:25:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

when there is no ECDT table and no _INI object for EC device, it will be 
enabled before scanning ACPI device. But it is too late after the following
the commit is merged.  
    >commit 7752d5cfe3d11ca0bb9c673ec38bd78ba6578f8e
    > Author: Robert Hancock <hancockr@shaw.ca>
    > Date:   Fri Feb 15 01:27:20 2008 -0800
       >x86: validate against acpi motherboard resources

   After the above commit is merged, OS will check whether MCFG area is 
reserved in ACPI motherboard resources by calling the function of 
acpi_get_devices when there exists MCFG table. In the acpi_get_devices the _STA
object will be evaluated to check the status of the ACPI device. On some broken
BIOS the MYEC object of EC device is initialized as one, which indicates that 
EC operation region is already accessible before enabling EC device.So on these
broken BIOS the EC operation region will be accessed in course of evaluating
the _STA object before enabling EC device, which causes that OS will print the
following warning messages:
    >ACPI Error (evregion-0315): No handler for Region [EC__] (ffff88007f8145e8)
[EmbeddedControl] [20080609]
    >ACPI Error (exfldio-0290): Region EmbeddedControl(3) has no handler [20080321]
    >ACPI Error (psparse-0530): Method parse/execution failed [\_SB_.PCI0.SBRG.
         EC__.BAT1._STA] (Node ffff81013fc17a00), AE_NOT_EXIST
    >ACPI Error (uteval-0233): Method execution failed [\_SB_.PCI0.SBRG.EC__.BAT1.
         _STA] (Node ffff81013fc17a00), AE_NOT_EXIST
    
Although the above warning message is harmless, it looks confusing. 
So it is necessary to enable EC device as early as possible.Maybe it is
appropriate to enable it immediately after ACPI full initialization.

http://bugzilla.kernel.org/show_bug.cgi?id=11255
http://bugzilla.kernel.org/show_bug.cgi?id=11374
http://bugzilla.kernel.org/show_bug.cgi?id=11660

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/bus.c          |    6 ++++++
 drivers/acpi/scan.c         |    4 ----
 include/acpi/acpi_drivers.h |    1 +
 3 files changed, 7 insertions(+), 4 deletions(-)

Index: linux-2.6/include/acpi/acpi_drivers.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_drivers.h
+++ linux-2.6/include/acpi/acpi_drivers.h
@@ -100,6 +100,7 @@ int acpi_power_transition(struct acpi_de
    -------------------------------------------------------------------------- */
 #ifdef CONFIG_ACPI_EC
 int acpi_ec_ecdt_probe(void);
+int acpi_boot_ec_enable(void);
 #endif
 
 /* --------------------------------------------------------------------------
Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -1545,7 +1545,6 @@ static int acpi_bus_scan_fixed(struct ac
 	return result;
 }
 
-int __init acpi_boot_ec_enable(void);
 
 static int __init acpi_scan_init(void)
 {
@@ -1579,9 +1578,6 @@ static int __init acpi_scan_init(void)
 	 */
 	result = acpi_bus_scan_fixed(acpi_root);
 
-	/* EC region might be needed at bus_scan, so enable it now */
-	acpi_boot_ec_enable();
-
 	if (!result)
 		result = acpi_bus_scan(acpi_root, &ops);
 
Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -749,6 +749,12 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
+	/*
+	 * Maybe EC region is required at bus_scan/acpi_get_devices. So it
+	 * is necessary to enable it as early as possible.
+	 */
+	acpi_boot_ec_enable();
+
 	printk(KERN_INFO PREFIX "Interpreter enabled\n");
 
 	/* Initialize sleep structures */


