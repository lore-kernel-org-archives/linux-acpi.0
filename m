From: "Thomas, Sujith" <sujith.thomas@intel.com>
Subject: [PATCH] 3/3 intel_menlow: syncing with acpi function changes
Date: Wed, 5 Nov 2008 16:16:44 +0530
Message-ID: <7D0189F5BE1DF549A570B212D1D5612182AF07@bgsmsx412.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48469 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754768AbYKEKsH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 05:48:07 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>

4th parameter of acpi_evaluate_integer changed to unsigned long long
acpi_driver_data() changed to inline function from macro

Signed-off-by: Sujith Thomas <sujith.thomas@intel.com>
---
 drivers/misc/intel_menlow.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6.27/drivers/misc/intel_menlow.c
===================================================================
--- linux-2.6.27.orig/drivers/misc/intel_menlow.c
+++ linux-2.6.27/drivers/misc/intel_menlow.c
@@ -62,7 +62,7 @@ static int memory_get_int_max_bandwidth(
 {
 	struct acpi_device *device = cdev->devdata;
 	acpi_handle handle = device->handle;
-	unsigned long value;
+	unsigned long long value;
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
 	acpi_status status = AE_OK;
@@ -98,7 +98,7 @@ static int memory_get_cur_bandwidth(stru
 {
 	struct acpi_device *device = cdev->devdata;
 	acpi_handle handle = device->handle;
-	unsigned long value;
+	unsigned long long value;
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
 	acpi_status status = AE_OK;
@@ -112,7 +112,7 @@ static int memory_get_cur_bandwidth(stru
 	if (ACPI_FAILURE(status))
 		return -EFAULT;
 
-	return sprintf(buf, "%ld\n", value);
+	return sprintf(buf, "%lld\n", value);
 }
 
 static int memory_set_cur_bandwidth(struct thermal_cooling_device
*cdev,
@@ -139,7 +139,7 @@ static int memory_set_cur_bandwidth(stru
 
 	status =
 	    acpi_evaluate_integer(handle, MEMORY_SET_BANDWIDTH,
&arg_list,
-				  (unsigned long *)&temp);
+				  (unsigned long long *)&temp);
 
 	printk(KERN_INFO
 	       "Bandwidth value was %d: status is %d\n", state, status);
@@ -183,7 +183,7 @@ static int intel_menlow_memory_add(struc
 		goto end;
 	}
 
-	acpi_driver_data(device) = cdev;
+	device->driver_data = cdev;
 	result = sysfs_create_link(&device->dev.kobj,
 				&cdev->device.kobj, "thermal_cooling");
 	if (result)
@@ -268,7 +268,7 @@ static int sensor_get_auxtrip(acpi_handl
 		return -EINVAL;
 
 	status = acpi_evaluate_integer(handle, index ? GET_AUX1 :
GET_AUX0,
-				       NULL, (unsigned long *)value);
+				       NULL, (unsigned long long
*)value);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -296,7 +296,7 @@ static int sensor_set_auxtrip(acpi_handl
 		return -EINVAL;
 
 	status = acpi_evaluate_integer(handle, index ? GET_AUX0 :
GET_AUX1,
-				       NULL, (unsigned long *)&temp);
+				       NULL, (unsigned long long
*)&temp);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 	if ((index && value < temp) || (!index && value > temp))
@@ -304,7 +304,7 @@ static int sensor_set_auxtrip(acpi_handl
 
 	arg.integer.value = value;
 	status = acpi_evaluate_integer(handle, index ? SET_AUX1 :
SET_AUX0,
-				       &args, (unsigned long *)&temp);
+				       &args, (unsigned long long
*)&temp);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -384,7 +384,7 @@ static ssize_t bios_enabled_show(struct 
 				 struct device_attribute *attr, char
*buf)
 {
 	acpi_status status;
-	unsigned long bios_enabled;
+	unsigned long long bios_enabled;
 
 	status = acpi_evaluate_integer(NULL, BIOS_ENABLED, NULL,
&bios_enabled);
 	if (ACPI_FAILURE(status))
@@ -500,7 +500,7 @@ static int __init intel_menlow_module_in
 {
 	int result = -ENODEV;
 	acpi_status status;
-	unsigned long enable;
+	unsigned long long enable;
 
 	if (acpi_disabled)
 		return result;
