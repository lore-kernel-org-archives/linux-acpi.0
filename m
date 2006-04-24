From: Thomas Renninger <trenn@suse.de>
Subject: Re: Exit ACPI drivers immediately if acpi is disabled
Date: Mon, 24 Apr 2006 12:52:37 +0200
Message-ID: <1145875957.3797.15.camel@queen.suse.de>
References: <200604211243.32276.trenn@suse.de>
	 <200604210918.47337.bjorn.helgaas@hp.com>
	 <200604211853.47117.trenn@suse.de>  <200604211918.13025.trenn@suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:18665 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750706AbWDXKwZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Apr 2006 06:52:25 -0400
In-Reply-To: <200604211918.13025.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

Rethinking about this: driver_registered is a bit too general variable?

Is this OK, now?

Subject: Exit ACPI processor module gracefully if acpi is disabled

Signed-off-by: Thomas Renninger <trenn@suse.de>

 drivers/acpi/processor_core.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.16/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.16.orig/drivers/acpi/processor_core.c
+++ linux-2.6.16/drivers/acpi/processor_core.c
@@ -906,6 +906,8 @@ void acpi_processor_uninstall_hotplug_no
  * ACPI, but needs symbols from this driver
  */
 
+static int processor_driver_registered = 0;
+
 static int __init acpi_processor_init(void)
 {
 	int result = 0;
@@ -926,6 +928,8 @@ static int __init acpi_processor_init(vo
 		return_VALUE(0);
 	}
 
+	processor_driver_registered = 1;
+
 	acpi_processor_install_hotplug_notify();
 
 	acpi_thermal_cpufreq_init();
@@ -943,12 +947,13 @@ static void __exit acpi_processor_exit(v
 
 	acpi_thermal_cpufreq_exit();
 
+	if (processor_driver_registered){
 	acpi_processor_uninstall_hotplug_notify();
 
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-
+	}
 	return_VOID;
 }
 


