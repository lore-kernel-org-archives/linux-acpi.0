From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/5] ACPI processor: Avoid WARN message on processor driver removal
Date: Thu, 17 Nov 2011 23:36:58 +0100
Message-ID: <1321569421-46220-3-git-send-email-trenn@suse.de>
References: <1321569421-46220-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34578 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab1KQWhN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Nov 2011 17:37:13 -0500
In-Reply-To: <1321569421-46220-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>

Only unregister acpi_idle driver if acpi_idle driver got
registered.

Also add a static acpi_idle_active variable for easy and nicer
checking whether acpi_idle_driver is active (as suggested by
Bjorn).

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
CC: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/processor_driver.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 3a4fc0c..790623f 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -110,6 +110,7 @@ static struct cpuidle_driver acpi_idle_driver = {
 	.name =		"acpi_idle",
 	.owner =	THIS_MODULE,
 };
+static int acpi_idle_active;
 
 #define INSTALL_NOTIFY_HANDLER		1
 #define UNINSTALL_NOTIFY_HANDLER	2
@@ -508,8 +509,7 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 	acpi_processor_get_throttling_info(pr);
 	acpi_processor_get_limit_info(pr);
 
-
-	if (cpuidle_get_driver() == &acpi_idle_driver)
+	if (acpi_idle_active)
 		acpi_processor_power_init(pr, device);
 
 	pr->cdev = thermal_cooling_device_register("Processor", device,
@@ -808,6 +808,7 @@ static int __init acpi_processor_init(void)
 	if (!cpuidle_register_driver(&acpi_idle_driver)) {
 		printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
 			acpi_idle_driver.name);
+		acpi_idle_active = 1;
 	} else {
 		printk(KERN_DEBUG "ACPI: acpi_idle yielding to %s\n",
 			cpuidle_get_driver()->name);
@@ -828,7 +829,8 @@ static int __init acpi_processor_init(void)
 	return 0;
 
 out_cpuidle:
-	cpuidle_unregister_driver(&acpi_idle_driver);
+	if (acpi_idle_active)
+		cpuidle_unregister_driver(&acpi_idle_driver);
 
 	return result;
 }
@@ -846,7 +848,8 @@ static void __exit acpi_processor_exit(void)
 
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
-	cpuidle_unregister_driver(&acpi_idle_driver);
+	if (acpi_idle_active)
+		cpuidle_unregister_driver(&acpi_idle_driver);
 
 	return;
 }
-- 
1.7.6.1

