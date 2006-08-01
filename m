From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Repost: acpi_processor_exit_acpi_off.patch
Date: Tue, 01 Aug 2006 15:24:16 +0200
Message-ID: <1154438656.4302.364.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-F78p1tav6OBfPX+UlcHF"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39319 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751602AbWHANUz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2006 09:20:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>


--=-F78p1tav6OBfPX+UlcHF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Exit ACPI processor module gracefully if acpi is disabled

Description: processor module might oops when machine is booted without
acpi support and the module gets rmmodded.
Module must still be loadable to provide cpufreq functionality even
without acpi.
Reference - http://bugzilla.novell.com/show_bug.cgi?id=165803

Signed-off-by: Thomas Renninger <mail@renninger.de>

 drivers/acpi/processor_core.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc2/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.18-rc2.orig/drivers/acpi/processor_core.c
+++ linux-2.6.18-rc2/drivers/acpi/processor_core.c
@@ -891,6 +891,8 @@ void acpi_processor_uninstall_hotplug_no
  * ACPI, but needs symbols from this driver
  */
 
+static int processor_driver_registered = 0;
+
 static int __init acpi_processor_init(void)
 {
 	int result = 0;
@@ -909,6 +911,7 @@ static int __init acpi_processor_init(vo
 		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 		return 0;
 	}
+	processor_driver_registered = 1;
 
 	acpi_processor_install_hotplug_notify();
 
@@ -926,11 +929,11 @@ static void __exit acpi_processor_exit(v
 
 	acpi_thermal_cpufreq_exit();
 
-	acpi_processor_uninstall_hotplug_notify();
-
-	acpi_bus_unregister_driver(&acpi_processor_driver);
-
-	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+	if (processor_driver_registered){
+		acpi_processor_uninstall_hotplug_notify();
+		acpi_bus_unregister_driver(&acpi_processor_driver);
+		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+	}
 
 	return;
 }


--=-F78p1tav6OBfPX+UlcHF
Content-Disposition: attachment; filename=acpi_processor_exit_acpi_off.patch
Content-Type: text/x-patch; name=acpi_processor_exit_acpi_off.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Exit ACPI processor module gracefully if acpi is disabled

Description: processor module might oops when machine is booted without
acpi support and the module gets rmmodded.
Module must still be loadable to provide cpufreq functionality even
without acpi.
Reference - http://bugzilla.novell.com/show_bug.cgi?id=165803

Signed-off-by: Thomas Renninger <mail@renninger.de>

 drivers/acpi/processor_core.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc2/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.18-rc2.orig/drivers/acpi/processor_core.c
+++ linux-2.6.18-rc2/drivers/acpi/processor_core.c
@@ -891,6 +891,8 @@ void acpi_processor_uninstall_hotplug_no
  * ACPI, but needs symbols from this driver
  */
 
+static int processor_driver_registered = 0;
+
 static int __init acpi_processor_init(void)
 {
 	int result = 0;
@@ -909,6 +911,7 @@ static int __init acpi_processor_init(vo
 		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 		return 0;
 	}
+	processor_driver_registered = 1;
 
 	acpi_processor_install_hotplug_notify();
 
@@ -926,11 +929,11 @@ static void __exit acpi_processor_exit(v
 
 	acpi_thermal_cpufreq_exit();
 
-	acpi_processor_uninstall_hotplug_notify();
-
-	acpi_bus_unregister_driver(&acpi_processor_driver);
-
-	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+	if (processor_driver_registered){
+		acpi_processor_uninstall_hotplug_notify();
+		acpi_bus_unregister_driver(&acpi_processor_driver);
+		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
+	}
 
 	return;
 }

--=-F78p1tav6OBfPX+UlcHF--

