From: mochel@linux.intel.com
Subject: [PATCH 22/24] Remove unneeded debugging macros in drivers/acpi/processor_throttling.c
Date: Mon, 17 Apr 2006 18:21:55 -0700
Message-ID: <11453233151522-git-send-email-mochel@linux.intel.com>
References: <11453233152030-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:45981 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932133AbWDRBZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:26 -0400
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr003.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PQer030537
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:26 GMT
In-Reply-To: <11453233152030-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/processor_throttling.c |   48 ++++++++++++++---------------------
 1 files changed, 19 insertions(+), 29 deletions(-)

applies-to: a75363b5033310198c804b052b0ad35fd925b52c
72e80a7f3b6461863c98f982fac94801a71474cb
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 97856ad..6552e22 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -55,13 +55,11 @@ static int acpi_processor_get_throttling
 	u32 duty_mask = 0;
 	u32 duty_value = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_get_throttling");
-
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (!pr->flags.throttling)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	pr->throttling.state = 0;
 
@@ -93,7 +91,7 @@ static int acpi_processor_get_throttling
 			  "Throttling state is T%d (%d%% throttling applied)\n",
 			  state, pr->throttling.states[state].performance));
 
-	return_VALUE(0);
+	return 0;
 }
 
 int acpi_processor_set_throttling(struct acpi_processor *pr, int state)
@@ -102,19 +100,17 @@ int acpi_processor_set_throttling(struct
 	u32 duty_mask = 0;
 	u32 duty_value = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_set_throttling");
-
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if ((state < 0) || (state > (pr->throttling.state_count - 1)))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (!pr->flags.throttling)
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 
 	if (state == pr->throttling.state)
-		return_VALUE(0);
+		return 0;
 
 	/*
 	 * Calculate the duty_value and duty_mask.
@@ -165,7 +161,7 @@ int acpi_processor_set_throttling(struct
 			  (pr->throttling.states[state].performance ? pr->
 			   throttling.states[state].performance / 10 : 0)));
 
-	return_VALUE(0);
+	return 0;
 }
 
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
@@ -174,8 +170,6 @@ int acpi_processor_get_throttling_info(s
 	int step = 0;
 	int i = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_get_throttling_info");
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
 			  pr->throttling.address,
@@ -183,21 +177,21 @@ int acpi_processor_get_throttling_info(s
 			  pr->throttling.duty_width));
 
 	if (!pr)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	/* TBD: Support ACPI 2.0 objects */
 
 	if (!pr->throttling.address) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling register\n"));
-		return_VALUE(0);
+		return 0;
 	} else if (!pr->throttling.duty_width) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling states\n"));
-		return_VALUE(0);
+		return 0;
 	}
 	/* TBD: Support duty_cycle values that span bit 4. */
 	else if ((pr->throttling.duty_offset + pr->throttling.duty_width) > 4) {
 		ACPI_WARNING((AE_INFO, "duty_cycle spans bit 4"));
-		return_VALUE(0);
+		return 0;
 	}
 
 	/*
@@ -208,7 +202,7 @@ int acpi_processor_get_throttling_info(s
 	if (errata.piix4.throttle) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Throttling not supported on PIIX4 A- or B-step\n"));
-		return_VALUE(0);
+		return 0;
 	}
 
 	pr->throttling.state_count = 1 << acpi_fadt.duty_width;
@@ -254,7 +248,7 @@ int acpi_processor_get_throttling_info(s
 	if (result)
 		pr->flags.throttling = 0;
 
-	return_VALUE(result);
+	return result;
 }
 
 /* proc interface */
@@ -266,8 +260,6 @@ static int acpi_processor_throttling_seq
 	int i = 0;
 	int result = 0;
 
-	ACPI_FUNCTION_TRACE("acpi_processor_throttling_seq_show");
-
 	if (!pr)
 		goto end;
 
@@ -296,7 +288,7 @@ static int acpi_processor_throttling_seq
 			    throttling.states[i].performance / 10 : 0));
 
       end:
-	return_VALUE(0);
+	return 0;
 }
 
 static int acpi_processor_throttling_open_fs(struct inode *inode,
@@ -315,13 +307,11 @@ static ssize_t acpi_processor_write_thro
 	struct acpi_processor *pr = (struct acpi_processor *)m->private;
 	char state_string[12] = { '\0' };
 
-	ACPI_FUNCTION_TRACE("acpi_processor_write_throttling");
-
 	if (!pr || (count > sizeof(state_string) - 1))
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (copy_from_user(state_string, buffer, count))
-		return_VALUE(-EFAULT);
+		return -EFAULT;
 
 	state_string[count] = '\0';
 
@@ -329,9 +319,9 @@ static ssize_t acpi_processor_write_thro
 					       simple_strtoul(state_string,
 							      NULL, 0));
 	if (result)
-		return_VALUE(result);
+		return result;
 
-	return_VALUE(count);
+	return count;
 }
 
 struct file_operations acpi_processor_throttling_fops = {
---
0.99.9.GIT


