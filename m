From: mochel@linux.intel.com
Subject: [PATCH 18/24] Remove unneeded debugging macros in drivers/acpi/processor_core.c
Date: Mon, 17 Apr 2006 18:21:54 -0700
Message-ID: <11453233141934-git-send-email-mochel@linux.intel.com>
References: <11453233141558-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:60303 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932124AbWDRBZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:26 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PPBH025149
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:26 GMT
In-Reply-To: <11453233141558-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/processor_core.c |  125 ++++++++++++++---------------------------
 1 files changed, 44 insertions(+), 81 deletions(-)

applies-to: fba2f5dacfe5a7967eadf3117a992745067a647f
6fb420237bb78f868964ae790cee1a77f47d8e54
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 7639bb7..29f8120 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -122,10 +122,8 @@ static int acpi_processor_errata_piix4(s
 	u8 value1 = 0;
 	u8 value2 = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_errata_piix4");
-
 	if (!dev)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/*
 	 * Note that 'dev' references the PIIX4 ACPI Controller.
@@ -218,7 +216,7 @@ static int acpi_processor_errata_piix4(s
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Type-F DMA livelock erratum (C3 disabled)\n"));
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_processor_errata(struct acpi_processor *pr)
@@ -226,10 +224,8 @@ static int acpi_processor_errata(struct 
 	int result = 0;
 	struct pci_dev *dev = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_errata");
-
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/*
 	 * PIIX4
@@ -242,7 +238,7 @@ static int acpi_processor_errata(struct 
 		pci_dev_put(dev);
 	}
 
-	return_VALUE(result);
+	return result;
 }
 
 /* --------------------------------------------------------------------------
@@ -258,10 +254,8 @@ static int acpi_processor_set_pdc(struct
 	struct acpi_object_list *pdc_in = pr->pdc;
 	acpi_status status = AE_OK;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_set_pdc");
-
 	if (!pdc_in)
-		return_VALUE(status);
+		return status;
 
 	status = acpi_evaluate_object(pr->handle, "_PDC", pdc_in, NULL);
 
@@ -269,7 +263,7 @@ static int acpi_processor_set_pdc(struct
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 		    "Could not evaluate _PDC, using legacy perf. control...\n"));
 
-	return_VALUE(status);
+	return status;
 }
 
 /* --------------------------------------------------------------------------
@@ -282,8 +276,6 @@ static int acpi_processor_info_seq_show(
 {
 	struct acpi_processor *pr = (struct acpi_processor *)seq->private;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_info_seq_show");
-
 	if (!pr)
 		goto end;
 
@@ -301,7 +293,7 @@ static int acpi_processor_info_seq_show(
 		   pr->flags.limit ? "yes" : "no");
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_processor_info_open_fs(struct inode *inode, struct file *file)
@@ -314,13 +306,11 @@ static int acpi_processor_add_fs(struct 
 {
 	struct proc_dir_entry *entry = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_add_fs");
-
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_processor_dir);
 		if (!acpi_device_dir(device))
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 	}
 	acpi_device_dir(device)->owner = THIS_MODULE;
 
@@ -328,7 +318,7 @@ static int acpi_processor_add_fs(struct 
 	entry = create_proc_entry(ACPI_PROCESSOR_FILE_INFO,
 				  S_IRUGO, acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-EIO);
+		return -EIO;
 	else {
 		entry->proc_fops = &acpi_processor_info_fops;
 		entry->data = acpi_driver_data(device);
@@ -340,7 +330,7 @@ static int acpi_processor_add_fs(struct 
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		return_VALUE(-EIO);
+		return -EIO;
 	else {
 		entry->proc_fops = &acpi_processor_throttling_fops;
 		entry->data = acpi_driver_data(device);
@@ -352,20 +342,18 @@ static int acpi_processor_add_fs(struct 
 				  S_IFREG | S_IRUGO | S_IWUSR,
 				  acpi_device_dir(device));
 	if (!entry)
-		return_VALUE( -EIO);
+		return  -EIO;
 	else {
 		entry->proc_fops = &acpi_processor_limit_fops;
 		entry->data = acpi_driver_data(device);
 		entry->owner = THIS_MODULE;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_processor_remove_fs(struct acpi_device *device)
 {
-	ACPI_FUNCTION_TRACE("acpi_processor_remove_fs");
-
 	if (acpi_device_dir(device)) {
 		remove_proc_entry(ACPI_PROCESSOR_FILE_INFO,
 				  acpi_device_dir(device));
@@ -377,7 +365,7 @@ static int acpi_processor_remove_fs(stru
 		acpi_device_dir(device) = NULL;
 	}
 
-	return_VALUE(0);
+	return 0;
 }
 
 /* Use the acpiid in MADT to map cpus in case of SMP */
@@ -424,10 +412,8 @@ static int acpi_processor_get_info(struc
 	int cpu_index;
 	static int cpu0_initialized;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_get_info");
-
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (num_online_cpus() > 1)
 		errata.smp = TRUE;
@@ -454,7 +440,7 @@ static int acpi_processor_get_info(struc
 	status = acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
 		ACPI_ERROR((AE_INFO, "Evaluating processor object"));
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	/*
@@ -486,7 +472,7 @@ static int acpi_processor_get_info(struc
 			ACPI_ERROR((AE_INFO,
 				    "Getting cpuindex for acpiid 0x%x",
 				    pr->acpi_id));
-			return_VALUE(-ENODEV);
+			return -ENODEV;
 		}
 	}
 
@@ -521,7 +507,7 @@ static int acpi_processor_get_info(struc
 	acpi_processor_get_throttling_info(pr);
 	acpi_processor_get_limit_info(pr);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void *processor_device_array[NR_CPUS];
@@ -532,14 +518,12 @@ static int acpi_processor_start(struct a
 	acpi_status status = AE_OK;
 	struct acpi_processor *pr;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_start");
-
 	pr = acpi_driver_data(device);
 
 	result = acpi_processor_get_info(pr);
 	if (result) {
 		/* Processor is physically not present */
-		return_VALUE(0);
+		return 0;
 	}
 
 	BUG_ON((pr->id >= NR_CPUS) || (pr->id < 0));
@@ -553,7 +537,7 @@ static int acpi_processor_start(struct a
 	    processor_device_array[pr->id] != (void *)device) {
 		printk(KERN_WARNING "BIOS reported wrong ACPI id"
 			"for the processor\n");
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 	processor_device_array[pr->id] = (void *)device;
 
@@ -581,7 +565,7 @@ static int acpi_processor_start(struct a
 
       end:
 
-	return_VALUE(result);
+	return result;
 }
 
 static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
@@ -589,13 +573,11 @@ static void acpi_processor_notify(acpi_h
 	struct acpi_processor *pr = (struct acpi_processor *)data;
 	struct acpi_device *device = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_notify");
-
 	if (!pr)
-		return_VOID;
+		return;
 
 	if (acpi_bus_get_device(pr->handle, &device))
-		return_VOID;
+		return;
 
 	switch (event) {
 	case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
@@ -613,21 +595,18 @@ static void acpi_processor_notify(acpi_h
 		break;
 	}
 
-	return_VOID;
 }
 
 static int acpi_processor_add(struct acpi_device *device)
 {
 	struct acpi_processor *pr = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_add");
-
 	if (!device)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	pr = kmalloc(sizeof(struct acpi_processor), GFP_KERNEL);
 	if (!pr)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	memset(pr, 0, sizeof(struct acpi_processor));
 
 	pr->handle = device->handle;
@@ -635,7 +614,7 @@ static int acpi_processor_add(struct acp
 	strcpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
 	acpi_driver_data(device) = pr;
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_processor_remove(struct acpi_device *device, int type)
@@ -643,21 +622,19 @@ static int acpi_processor_remove(struct 
 	acpi_status status = AE_OK;
 	struct acpi_processor *pr = NULL;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_remove");
-
 	if (!device || !acpi_driver_data(device))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	pr = (struct acpi_processor *)acpi_driver_data(device);
 
 	if (pr->id >= NR_CPUS) {
 		kfree(pr);
-		return_VALUE(0);
+		return 0;
 	}
 
 	if (type == ACPI_BUS_REMOVAL_EJECT) {
 		if (acpi_processor_handle_eject(pr))
-			return_VALUE(-EINVAL);
+			return -EINVAL;
 	}
 
 	acpi_processor_power_exit(pr, device);
@@ -671,7 +648,7 @@ static int acpi_processor_remove(struct 
 
 	kfree(pr);
 
-	return_VALUE(0);
+	return 0;
 }
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
@@ -686,14 +663,12 @@ static int is_processor_present(acpi_han
 	acpi_status status;
 	unsigned long sta = 0;
 
-	ACPI_FUNCTION_TRACE("is_processor_present");
-
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
 	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_PRESENT)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Processor Device is not present"));
-		return_VALUE(0);
+		return 0;
 	}
-	return_VALUE(1);
+	return 1;
 }
 
 static
@@ -703,30 +678,28 @@ int acpi_processor_device_add(acpi_handl
 	struct acpi_device *pdev;
 	struct acpi_processor *pr;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_device_add");
-
 	if (acpi_get_parent(handle, &phandle)) {
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	if (acpi_bus_get_device(phandle, &pdev)) {
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	if (acpi_bus_add(device, pdev, handle, ACPI_BUS_TYPE_PROCESSOR)) {
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	}
 
 	acpi_bus_start(*device);
 
 	pr = acpi_driver_data(*device);
 	if (!pr)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	if ((pr->id >= 0) && (pr->id < NR_CPUS)) {
 		kobject_uevent(&(*device)->kobj, KOBJ_ONLINE);
 	}
-	return_VALUE(0);
+	return 0;
 }
 
 static void
@@ -736,8 +709,6 @@ acpi_processor_hotplug_notify(acpi_handl
 	struct acpi_device *device = NULL;
 	int result;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_hotplug_notify");
-
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
@@ -788,7 +759,7 @@ acpi_processor_hotplug_notify(acpi_handl
 		if (!pr) {
 			ACPI_ERROR((AE_INFO,
 				    "Driver data is NULL, dropping EJECT"));
-			return_VOID;
+			return;
 		}
 
 		if ((pr->id < NR_CPUS) && (cpu_present(pr->id)))
@@ -800,7 +771,6 @@ acpi_processor_hotplug_notify(acpi_handl
 		break;
 	}
 
-	return_VOID;
 }
 
 static acpi_status
@@ -839,21 +809,19 @@ processor_walk_namespace_cb(acpi_handle 
 
 static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu)
 {
-	ACPI_FUNCTION_TRACE("acpi_processor_hotadd_init");
-
 	if (!is_processor_present(handle)) {
-		return_VALUE(AE_ERROR);
+		return AE_ERROR;
 	}
 
 	if (acpi_map_lsapic(handle, p_cpu))
-		return_VALUE(AE_ERROR);
+		return AE_ERROR;
 
 	if (arch_register_cpu(*p_cpu)) {
 		acpi_unmap_lsapic(*p_cpu);
-		return_VALUE(AE_ERROR);
+		return AE_ERROR;
 	}
 
-	return_VALUE(AE_OK);
+	return AE_OK;
 }
 
 static int acpi_processor_handle_eject(struct acpi_processor *pr)
@@ -910,20 +878,18 @@ static int __init acpi_processor_init(vo
 {
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_init");
-
 	memset(&processors, 0, sizeof(processors));
 	memset(&errata, 0, sizeof(errata));
 
 	acpi_processor_dir = proc_mkdir(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 	if (!acpi_processor_dir)
-		return_VALUE(0);
+		return 0;
 	acpi_processor_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_processor_driver);
 	if (result < 0) {
 		remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
-		return_VALUE(0);
+		return 0;
 	}
 
 	acpi_processor_install_hotplug_notify();
@@ -932,13 +898,11 @@ static int __init acpi_processor_init(vo
 
 	acpi_processor_ppc_init();
 
-	return_VALUE(0);
+	return 0;
 }
 
 static void __exit acpi_processor_exit(void)
 {
-	ACPI_FUNCTION_TRACE("acpi_processor_exit");
-
 	acpi_processor_ppc_exit();
 
 	acpi_thermal_cpufreq_exit();
@@ -949,7 +913,6 @@ static void __exit acpi_processor_exit(v
 
 	remove_proc_entry(ACPI_PROCESSOR_CLASS, acpi_root_dir);
 
-	return_VOID;
 }
 
 module_init(acpi_processor_init);
---
0.99.9.GIT


