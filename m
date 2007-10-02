From: akpm@linux-foundation.org
Subject: [patch 1/8] Exit ACPI processor module gracefully if acpi is disabled
Date: Tue, 02 Oct 2007 13:24:06 -0700
Message-ID: <200710022024.l92KO6ae020453@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57824 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752129AbXJBUYw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Oct 2007 16:24:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, trenn@suse.de

From: Thomas Renninger <trenn@suse.de>

akpm: needs a changelog

Signed-off-by: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_core.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff -puN drivers/acpi/processor_core.c~exit-acpi-processor-module-gracefully-if-acpi-is-disabled drivers/acpi/processor_core.c
--- a/drivers/acpi/processor_core.c~exit-acpi-processor-module-gracefully-if-acpi-is-disabled
+++ a/drivers/acpi/processor_core.c
@@ -1030,6 +1030,8 @@ void acpi_processor_uninstall_hotplug_no
  * ACPI, but needs symbols from this driver
  */
 
+static int processor_driver_registered;
+
 static int __init acpi_processor_init(void)
 {
 	int result = 0;
@@ -1055,6 +1057,8 @@ static int __init acpi_processor_init(vo
 		return result;
 	}
 
+	processor_driver_registered = 1;
+
 	acpi_processor_install_hotplug_notify();
 
 	acpi_thermal_cpufreq_init();
@@ -1068,15 +1072,12 @@ static void __exit acpi_processor_exit(v
 {
 
 	acpi_processor_ppc_exit();
-
-	acpi_thermal_cpufreq_exit();
-
-	acpi_processor_uninstall_hotplug_notify();
-
-	acpi_bus_unregister_driver(&acpi_processor_driver);
-
-	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-
+	if (processor_driver_registered) {
+		acpi_thermal_cpufreq_exit();
+		acpi_processor_uninstall_hotplug_notify();
+		acpi_bus_unregister_driver(&acpi_processor_driver);
+		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+	}
 	return;
 }
 
_
