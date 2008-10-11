From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/85] ACPI: Get the device power state in the course of
 scanning device
Date: Sat, 11 Oct 2008 02:35:23 -0400
Message-ID: <9a252fe1069f759a4fe76fdffce3b589b899bcdf.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:41886 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbYJKGgt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:36:49 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Andi Kleen <ak@linux.intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Get the device power state in the course of scanning device if the device
power flag is power_managable. i.e. The device has the _PSx/_PRx object.

At the same time before the drivers/acpi/power module is loaded, there is no
relation between acpi_power_resource and acpi device. So the first parameter
of acpi_power_get_state is changed to acpi_handle.

http://bugzilla.kernel.org/show_bug.cgi?id=8049
http://bugzilla.kernel.org/show_bug.cgi?id=11000

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/acpi/power.c |   30 ++++++++++++++++--------------
 drivers/acpi/scan.c  |    1 +
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 4ab21cb..e7bab75 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -128,16 +128,16 @@ acpi_power_get_context(acpi_handle handle,
 	return 0;
 }
 
-static int acpi_power_get_state(struct acpi_power_resource *resource, int *state)
+static int acpi_power_get_state(acpi_handle handle, int *state)
 {
 	acpi_status status = AE_OK;
 	unsigned long sta = 0;
 
 
-	if (!resource || !state)
+	if (!handle || !state)
 		return -EINVAL;
 
-	status = acpi_evaluate_integer(resource->device->handle, "_STA", NULL, &sta);
+	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -145,7 +145,7 @@ static int acpi_power_get_state(struct acpi_power_resource *resource, int *state
 			      ACPI_POWER_RESOURCE_STATE_OFF;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] is %s\n",
-			  resource->name, state ? "on" : "off"));
+			  acpi_ut_get_node_name(handle), state ? "on" : "off"));
 
 	return 0;
 }
@@ -153,7 +153,6 @@ static int acpi_power_get_state(struct acpi_power_resource *resource, int *state
 static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
 {
 	int result = 0, state1;
-	struct acpi_power_resource *resource = NULL;
 	u32 i = 0;
 
 
@@ -161,12 +160,15 @@ static int acpi_power_get_list_state(struct acpi_handle_list *list, int *state)
 		return -EINVAL;
 
 	/* The state of the list is 'on' IFF all resources are 'on'. */
+	/* */
 
 	for (i = 0; i < list->count; i++) {
-		result = acpi_power_get_context(list->handles[i], &resource);
-		if (result)
-			return result;
-		result = acpi_power_get_state(resource, &state1);
+		/*
+		 * The state of the power resource can be obtained by
+		 * using the ACPI handle. In such case it is unnecessary to
+		 * get the Power resource first and then get its state again.
+		 */
+		result = acpi_power_get_state(list->handles[i], &state1);
 		if (result)
 			return result;
 
@@ -226,7 +228,7 @@ static int acpi_power_on(acpi_handle handle, struct acpi_device *dev)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	result = acpi_power_get_state(resource, &state);
+	result = acpi_power_get_state(resource->device->handle, &state);
 	if (result)
 		return result;
 	if (state != ACPI_POWER_RESOURCE_STATE_ON)
@@ -277,7 +279,7 @@ static int acpi_power_off_device(acpi_handle handle, struct acpi_device *dev)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	result = acpi_power_get_state(resource, &state);
+	result = acpi_power_get_state(handle, &state);
 	if (result)
 		return result;
 	if (state != ACPI_POWER_RESOURCE_STATE_OFF)
@@ -555,7 +557,7 @@ static int acpi_power_seq_show(struct seq_file *seq, void *offset)
 	if (!resource)
 		goto end;
 
-	result = acpi_power_get_state(resource, &state);
+	result = acpi_power_get_state(resource->device->handle, &state);
 	if (result)
 		goto end;
 
@@ -668,7 +670,7 @@ static int acpi_power_add(struct acpi_device *device)
 	resource->system_level = acpi_object.power_resource.system_level;
 	resource->order = acpi_object.power_resource.resource_order;
 
-	result = acpi_power_get_state(resource, &state);
+	result = acpi_power_get_state(device->handle, &state);
 	if (result)
 		goto end;
 
@@ -735,7 +737,7 @@ static int acpi_power_resume(struct acpi_device *device)
 
 	resource = (struct acpi_power_resource *)acpi_driver_data(device);
 
-	result = acpi_power_get_state(resource, &state);
+	result = acpi_power_get_state(device->handle, &state);
 	if (result)
 		return result;
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f6f52c1..308ddb1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -807,6 +807,7 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 	/* TBD: System wake support and resource requirements. */
 
 	device->power.state = ACPI_STATE_UNKNOWN;
+	acpi_bus_get_power(device->handle, &(device->power.state));
 
 	return 0;
 }
-- 
1.5.5.1

