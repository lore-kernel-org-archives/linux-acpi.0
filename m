From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH_3/7] ACPI: Not use calculated T-states from FADT.duty_width
	when _TSS exists
Date: Thu, 15 Nov 2007 17:02:03 +0800
Message-ID: <1195117323.6817.35.camel@yakui_zhao.sh.intel.com>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
	 <200710092343.40843.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12757 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756622AbXKOIwG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2007 03:52:06 -0500
In-Reply-To: <200710092343.40843.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Not use calculated T-states from FADT.duty_width when _TSS exists
>From : Zhao Yakui <yakui.zhao@intel.com>

If _TSS exists, it will return supported T-states. 
It doesn't make sense to use calculated T-states from FADT.duty_width.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 drivers/acpi/processor_throttling.c |   66 +++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 30 deletions(-)

Index: linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.24-rc1.orig/drivers/acpi/processor_throttling.c
+++ linux-2.6.24-rc1/drivers/acpi/processor_throttling.c
@@ -478,6 +478,40 @@ static int acpi_processor_get_throttling
 	return pr->throttling.acpi_processor_get_throttling(pr);
 }
 
+static int acpi_processor_get_fadt_info(struct acpi_processor *pr)
+{
+	int i, step;
+
+	if (!pr->throttling.address) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling register\n"));
+		return -EINVAL;
+	} else if (!pr->throttling.duty_width) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling states\n"));
+		return -EINVAL;
+	}
+	/* TBD: Support duty_cycle values that span bit 4. */
+	else if ((pr->throttling.duty_offset + pr->throttling.duty_width) > 4) {
+		printk(KERN_WARNING PREFIX "duty_cycle spans bit 4\n");
+		return -EINVAL;
+	}
+
+	pr->throttling.state_count = 1 << acpi_gbl_FADT.duty_width;
+
+	/*
+	 * Compute state values. Note that throttling displays a linear power
+	 * performance relationship (at 50% performance the CPU will consume
+	 * 50% power).  Values are in 1/10th of a percent to preserve accuracy.
+	 */
+
+	step = (1000 / pr->throttling.state_count);
+
+	for (i = 0; i < pr->throttling.state_count; i++) {
+		pr->throttling.states[i].performance = 1000 - step * i;
+		pr->throttling.states[i].power = 1000 - step * i;
+	}
+	return 0;
+}
+
 static int acpi_processor_set_throttling_fadt(struct acpi_processor *pr,
 					      int state)
 {
@@ -591,8 +625,6 @@ int acpi_processor_set_throttling(struct
 int acpi_processor_get_throttling_info(struct acpi_processor *pr)
 {
 	int result = 0;
-	int step = 0;
-	int i = 0;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
@@ -611,6 +643,8 @@ int acpi_processor_get_throttling_info(s
 		acpi_processor_get_throttling_states(pr) ||
 		acpi_processor_get_platform_limit(pr))
 	{
+		if (acpi_processor_get_fadt_info(pr))
+			return 0;
 		pr->throttling.acpi_processor_get_throttling =
 		    &acpi_processor_get_throttling_fadt;
 		pr->throttling.acpi_processor_set_throttling =
@@ -624,19 +658,6 @@ int acpi_processor_get_throttling_info(s
 
 	acpi_processor_get_tsd(pr);
 
-	if (!pr->throttling.address) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling register\n"));
-		return 0;
-	} else if (!pr->throttling.duty_width) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling states\n"));
-		return 0;
-	}
-	/* TBD: Support duty_cycle values that span bit 4. */
-	else if ((pr->throttling.duty_offset + pr->throttling.duty_width) > 4) {
-		printk(KERN_WARNING PREFIX "duty_cycle spans bit 4\n");
-		return 0;
-	}
-
 	/*
 	 * PIIX4 Errata: We don't support throttling on the original PIIX4.
 	 * This shouldn't be an issue as few (if any) mobile systems ever
@@ -648,21 +669,6 @@ int acpi_processor_get_throttling_info(s
 		return 0;
 	}
 
-	pr->throttling.state_count = 1 << acpi_gbl_FADT.duty_width;
-
-	/*
-	 * Compute state values. Note that throttling displays a linear power/
-	 * performance relationship (at 50% performance the CPU will consume
-	 * 50% power).  Values are in 1/10th of a percent to preserve accuracy.
-	 */
-
-	step = (1000 / pr->throttling.state_count);
-
-	for (i = 0; i < pr->throttling.state_count; i++) {
-		pr->throttling.states[i].performance = step * i;
-		pr->throttling.states[i].power = step * i;
-	}
-
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d throttling states\n",
 			  pr->throttling.state_count));
 
