From: mochel@linux.intel.com
Subject: [PATCH 21/24] Remove unneeded debugging macros in drivers/acpi/processor_thermal.c
Date: Mon, 17 Apr 2006 18:21:55 -0700
Message-ID: <11453233152030-git-send-email-mochel@linux.intel.com>
References: <11453233154124-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:60815 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932130AbWDRBZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:26 -0400
Received: from orsfmr101.jf.intel.com (orsfmr101.jf.intel.com [10.7.209.17])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PQBH025157
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:26 GMT
In-Reply-To: <11453233154124-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/processor_thermal.c |   42 ++++++++++++++------------------------
 1 files changed, 16 insertions(+), 26 deletions(-)

applies-to: 72188ed0aa80350aa7d44e92d7d45257bda7c522
57c8be1f7b709b279845d1e4f6e50fd94ce51ce8
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index c2095ab..b2fd31d 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -54,13 +54,11 @@ static int acpi_processor_apply_limit(st
 	u16 px = 0;
 	u16 tx = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_apply_limit");
-
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (!pr->flags.limit)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	if (pr->flags.throttling) {
 		if (pr->limit.user.tx > tx)
@@ -84,7 +82,7 @@ static int acpi_processor_apply_limit(st
 	if (result)
 		ACPI_ERROR((AE_INFO, "Unable to set limit"));
 
-	return_VALUE(result);
+	return result;
 }
 
 #ifdef CONFIG_CPU_FREQ
@@ -200,19 +198,17 @@ int acpi_processor_set_thermal_limit(acp
 	struct acpi_device *device = NULL;
 	int tx = 0, max_tx_px = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_set_thermal_limit");
-
 	if ((type < ACPI_PROCESSOR_LIMIT_NONE)
 	    || (type > ACPI_PROCESSOR_LIMIT_DECREMENT))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	result = acpi_bus_get_device(handle, &device);
 	if (result)
-		return_VALUE(result);
+		return result;
 
 	pr = (struct acpi_processor *)acpi_driver_data(device);
 	if (!pr)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	/* Thermal limits are always relative to the current Px/Tx state. */
 	if (pr->flags.throttling)
@@ -296,22 +292,20 @@ int acpi_processor_set_thermal_limit(acp
 	} else
 		result = 0;
 	if (max_tx_px)
-		return_VALUE(1);
+		return 1;
 	else
-		return_VALUE(result);
+		return result;
 }
 
 int acpi_processor_get_limit_info(struct acpi_processor *pr)
 {
-	ACPI_FUNCTION_TRACE("acpi_processor_get_limit_info");
-
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (pr->flags.throttling)
 		pr->flags.limit = 1;
 
-	return_VALUE(0);
+	return 0;
 }
 
 /* /proc interface */
@@ -320,8 +314,6 @@ static int acpi_processor_limit_seq_show
 {
 	struct acpi_processor *pr = (struct acpi_processor *)seq->private;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_limit_seq_show");
-
 	if (!pr)
 		goto end;
 
@@ -338,7 +330,7 @@ static int acpi_processor_limit_seq_show
 		   pr->limit.thermal.px, pr->limit.thermal.tx);
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_processor_limit_open_fs(struct inode *inode, struct file *file)
@@ -358,34 +350,32 @@ static ssize_t acpi_processor_write_limi
 	int px = 0;
 	int tx = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_write_limit");
-
 	if (!pr || (count > sizeof(limit_string) - 1)) {
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 
 	if (copy_from_user(limit_string, buffer, count)) {
-		return_VALUE(-EFAULT);
+		return -EFAULT;
 	}
 
 	limit_string[count] = '\0';
 
 	if (sscanf(limit_string, "%d:%d", &px, &tx) != 2) {
 		ACPI_ERROR((AE_INFO, "Invalid data format"));
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 
 	if (pr->flags.throttling) {
 		if ((tx < 0) || (tx > (pr->throttling.state_count - 1))) {
 			ACPI_ERROR((AE_INFO, "Invalid tx"));
-			return_VALUE(-EINVAL);
+			return -EINVAL;
 		}
 		pr->limit.user.tx = tx;
 	}
 
 	result = acpi_processor_apply_limit(pr);
 
-	return_VALUE(count);
+	return count;
 }
 
 struct file_operations acpi_processor_limit_fops = {
---
0.99.9.GIT


