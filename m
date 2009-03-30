From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 03/10] ACPI: processor: use .notify method instead of
	installing handler directly
Date: Mon, 30 Mar 2009 11:48:24 -0600
Message-ID: <20090330174823.20905.32501.stgit@bob.kio>
References: <20090330174646.20905.18465.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:28456 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbZC3RsZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2009 13:48:25 -0400
In-Reply-To: <20090330174646.20905.18465.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Zhang Rui <rui.zhang@intel.com>
CC: Zhao Yakui <yakui.zhao@intel.com>
CC: Venki Pallipadi <venkatesh.pallipadi@intel.com>
CC: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---
 drivers/acpi/processor_core.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 0cc2fd3..0e97d70 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -82,7 +82,7 @@ static int acpi_processor_add(struct acpi_device *device);
 static int acpi_processor_start(struct acpi_device *device);
 static int acpi_processor_remove(struct acpi_device *device, int type);
 static int acpi_processor_info_open_fs(struct inode *inode, struct file *file);
-static void acpi_processor_notify(acpi_handle handle, u32 event, void *data);
+static void acpi_processor_notify(struct acpi_device *device, u32 event);
 static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
 
@@ -104,6 +104,7 @@ static struct acpi_driver acpi_processor_driver = {
 		.start = acpi_processor_start,
 		.suspend = acpi_processor_suspend,
 		.resume = acpi_processor_resume,
+		.notify = acpi_processor_notify,
 		},
 };
 
@@ -666,7 +667,6 @@ static DEFINE_PER_CPU(void *, processor_device_array);
 static int __cpuinit acpi_processor_start(struct acpi_device *device)
 {
 	int result = 0;
-	acpi_status status = AE_OK;
 	struct acpi_processor *pr;
 	struct sys_device *sysdev;
 
@@ -703,9 +703,6 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 	if (sysfs_create_link(&device->dev.kobj, &sysdev->kobj, "sysdev"))
 		return -EFAULT;
 
-	status = acpi_install_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
-					     acpi_processor_notify, pr);
-
 	/* _PDC call should be done before doing anything else (if reqd.). */
 	arch_acpi_processor_init_pdc(pr);
 	acpi_processor_set_pdc(pr);
@@ -751,18 +748,14 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 	return result;
 }
 
-static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_processor_notify(struct acpi_device *device, u32 event)
 {
-	struct acpi_processor *pr = data;
-	struct acpi_device *device = NULL;
+	struct acpi_processor *pr = acpi_driver_data(device);
 	int saved;
 
 	if (!pr)
 		return;
 
-	if (acpi_bus_get_device(pr->handle, &device))
-		return;
-
 	switch (event) {
 	case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
 		saved = pr->performance_platform_limit;
@@ -841,7 +834,6 @@ static int acpi_processor_add(struct acpi_device *device)
 
 static int acpi_processor_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = AE_OK;
 	struct acpi_processor *pr = NULL;
 
 
@@ -860,9 +852,6 @@ static int acpi_processor_remove(struct acpi_device *device, int type)
 
 	acpi_processor_power_exit(pr, device);
 
-	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
-					    acpi_processor_notify);
-
 	sysfs_remove_link(&device->dev.kobj, "sysdev");
 
 	acpi_processor_remove_fs(device);

