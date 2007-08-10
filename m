From: akpm@linux-foundation.org
Subject: [patch 1/6] Exit ACPI processor module gracefully if acpi is disabled
Date: Fri, 10 Aug 2007 13:45:15 -0700
Message-ID: <200708102045.l7AKjFJB007821@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37156 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760617AbXHJUqJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Aug 2007 16:46:09 -0400
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
 1 files changed, 9 insertions(+), 4 deletions(-)

diff -puN drivers/acpi/processor_core.c~exit-acpi-processor-module-gracefully-if-acpi-is-disabled drivers/acpi/processor_core.c
--- a/drivers/acpi/processor_core.c~exit-acpi-processor-module-gracefully-if-acpi-is-disabled
+++ a/drivers/acpi/processor_core.c
@@ -1001,6 +1001,8 @@ void acpi_processor_uninstall_hotplug_no
  * ACPI, but needs symbols from this driver
  */
 
+static int processor_driver_registered;
+
 static int __init acpi_processor_init(void)
 {
 	int result = 0;
@@ -1026,6 +1028,8 @@ static int __init acpi_processor_init(vo
 		return result;
 	}
 
+	processor_driver_registered = 1;
+
 	acpi_processor_install_hotplug_notify();
 
 	acpi_thermal_cpufreq_init();
@@ -1046,12 +1050,13 @@ static void __exit acpi_processor_exit(v
 
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
