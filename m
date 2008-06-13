From: Alok Kataria <akataria@vmware.com>
Subject: [RFC PATCH] ACPI: eject device synchronously
Date: Fri, 13 Jun 2008 13:28:11 -0700
Message-ID: <1213388891.22105.18.camel@promb-2n-dhcp368.eng.vmware.com>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.113.40.141]:53932 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752096AbYFMU2N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jun 2008 16:28:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, rui.zhang@intel.com
Cc: linux-acpi@vger.kernel.org

This is w.r.t some ACPI changes, to fix a deadlock when ejecting a cpu.
In http://bugzilla.kernel.org/show_bug.cgi?id=9772#c31
Len raises some concerns about a theoretical race. In the current code path we
could return to the userspace without doing the actual eject of the device. 
This deferring of device eject and device unregistering was done to fix a
deadlock at cpu eject time. 

IMO, we could do with only deferring the device unregistration part to the
thread. So before we return to the userspace we make sure that we execute the
_PS3 and _EJ0 objects of the device being removed. So the device is physically
removed when the write to the sysfile completes. 

patch on top of acpi-test.
--
VMware, Inc. is providing the following patch to you under the terms of the GPL
version 2 and no later version. This patch is provided as is, with no
warranties or support. VMware disclaims all liability in connection with
the use/inability to use this patch. Any use of the attached is
considered acceptance of the above.

Signed-off-by: Alok N Kataria <akataria@vmware.com>
Cc: Zhang Rui <rui.zhang@intel.com>

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c	2008-06-13 10:51:16.000000000 -0700
+++ linux-2.6/drivers/acpi/scan.c	2008-06-13 11:32:14.000000000 -0700
@@ -96,14 +96,7 @@
 
 static int acpi_bus_hot_remove_device(void *context)
 {
-	struct acpi_device *device;
-	acpi_handle handle = context;
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
-	acpi_status status = AE_OK;
-
-	if (acpi_bus_get_device(handle, &device))
-		return 0;
+	struct acpi_device *device = context;
 
 	if (!device)
 		return 0;
@@ -118,32 +111,6 @@
 		return -1;
 	}
 
-	/* power off device */
-	status = acpi_evaluate_object(handle, "_PS3", NULL, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
-		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-				"Power-off device failed\n"));
-
-	if (device->flags.lockable) {
-		arg_list.count = 1;
-		arg_list.pointer = &arg;
-		arg.type = ACPI_TYPE_INTEGER;
-		arg.integer.value = 0;
-		acpi_evaluate_object(handle, "_LCK", &arg_list, NULL);
-	}
-
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = 1;
-
-	/*
-	 * TBD: _EJD support.
-	 */
-	status = acpi_evaluate_object(handle, "_EJ0", &arg_list, NULL);
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
 	return 0;
 }
 
@@ -153,6 +120,8 @@
 {
 	int ret = count;
 	acpi_status status;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
 	acpi_object_type type = 0;
 	struct acpi_device *acpi_device = to_acpi_device(d);
 	struct task_struct *task;
@@ -172,9 +141,37 @@
 		goto err;
 	}
 
-	/* remove the device in another thread to fix the deadlock issue */
+	/* power off device */
+	status = acpi_evaluate_object(acpi_device->handle, "_PS3", NULL, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+				"Power-off device failed\n"));
+
+	if (acpi_device->flags.lockable) {
+		arg_list.count = 1;
+		arg_list.pointer = &arg;
+		arg.type = ACPI_TYPE_INTEGER;
+		arg.integer.value = 0;
+		acpi_evaluate_object(acpi_device->handle,
+					"_LCK", &arg_list, NULL);
+	}
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = 1;
+
+	/*
+	 * TBD: _EJD support.
+	 */
+	status = acpi_evaluate_object(acpi_device->handle,
+					"_EJ0", &arg_list, NULL);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	/* unregister the device in another thread to fix the deadlock issue */
 	task = kthread_run(acpi_bus_hot_remove_device,
-				acpi_device->handle, "acpi_hot_remove_device");
+				acpi_device, "acpi_hot_remove_device");
 	if (IS_ERR(task))
 		ret = PTR_ERR(task);
 err:


