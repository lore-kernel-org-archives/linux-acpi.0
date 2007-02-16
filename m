From: akpm@linux-foundation.org
Subject: [patch 1/1] Exit ACPI processor module gracefully if acpi is disabled
Date: Fri, 16 Feb 2007 01:36:51 -0800
Message-ID: <200702160936.l1G9aqIj026320@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:36350 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966266AbXBPJiJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Feb 2007 04:38:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, trenn@suse.de

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_core.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff -puN drivers/acpi/processor_core.c~exit-acpi-processor-module-gracefully-if-acpi-is-disabled drivers/acpi/processor_core.c
--- a/drivers/acpi/processor_core.c~exit-acpi-processor-module-gracefully-if-acpi-is-disabled
+++ a/drivers/acpi/processor_core.c
@@ -993,6 +993,8 @@ void acpi_processor_uninstall_hotplug_no
  * ACPI, but needs symbols from this driver
  */
 
+static int processor_driver_registered;
+
 static int __init acpi_processor_init(void)
 {
 	int result = 0;
@@ -1018,6 +1020,8 @@ static int __init acpi_processor_init(vo
 		return result;
 	}
 
+	processor_driver_registered = 1;
+
 	acpi_processor_install_hotplug_notify();
 
 	acpi_thermal_cpufreq_init();
@@ -1034,12 +1038,13 @@ static void __exit acpi_processor_exit(v
 
 	acpi_thermal_cpufreq_exit();
 
-	acpi_processor_uninstall_hotplug_notify();
-
-	acpi_bus_unregister_driver(&acpi_processor_driver);
+	if (processor_driver_registered) {
+		acpi_processor_uninstall_hotplug_notify();
 
-	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+		acpi_bus_unregister_driver(&acpi_processor_driver);
 
+		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+	}
 	return;
 }
 
_
