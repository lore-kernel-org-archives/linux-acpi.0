From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [PATCH] Enable C3 even when PM2 control block is not present
Date: Fri, 8 Jun 2007 13:27:11 -0700
Message-ID: <20070608202711.GB2184@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21820 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460AbXFHUa5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jun 2007 16:30:57 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org



On systems that do not have pm2_control_block, we cannot really use
ARB_DISABLE before C3. We used to disable C3 totally on such systems.

To be compatible with Windows, we need to enable C3 on such systems now.
We just skip ARB_DISABLE step before entering the C3-state and assume
hardware is handling things correctly. Also, ACPI spec is not clear
about pm2_control is _needed_ for C3 or not.

We have atleast one system that need this to enable C3.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.22-rc-mm/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.22-rc-mm.orig/drivers/acpi/processor_idle.c	2007-06-07 10:47:00.000000000 -0700
+++ linux-2.6.22-rc-mm/drivers/acpi/processor_idle.c	2007-06-07 11:35:07.000000000 -0700
@@ -506,9 +506,9 @@
 	if (pr->flags.bm_check) {
 		/* bus mastering control is necessary */
 		if (!pr->flags.bm_control) {
+			/* In this case we enter C3 without bus mastering */
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "C3 support requires bus mastering control\n"));
-			return;
+				"C3 support without bus mastering control\n"));
 		}
 	} else {
 		/*
@@ -977,8 +977,17 @@
 		return 0;
 	}
 
-	/* disable bus master */
-	if (pr->flags.bm_check) {
+	/*
+	 * disable bus master
+	 * bm_check implies we need ARB_DIS
+	 * !bm_check implies we need cache flush
+	 * bm_control implies whether we can do ARB_DIS
+	 *
+	 * That leaves a case where bm_check is set and bm_control is not set.
+	 * In that case we cannot do much, we enter C3 without doing anything.
+	 * This the other OS compatible behavior.
+	 */
+	if (pr->flags.bm_check && pr->flags.bm_control) {
 		spin_lock(&c3_lock);
 			c3_cpu_count++;
 		if (c3_cpu_count == num_online_cpus()) {
@@ -989,7 +998,7 @@
 			acpi_set_register(ACPI_BITREG_ARB_DISABLE, 1);
 		}
 		spin_unlock(&c3_lock);
-	} else {
+	} else if (!pr->flags.bm_check) {
 		/* SMP with no shared cache... Invalidate cache  */
 		ACPI_FLUSH_CPU_CACHE();
 	}
@@ -1000,7 +1009,7 @@
 	acpi_idle_do_entry(cx);
 	t2 = inl(acpi_gbl_FADT.xpm_timer_block.address);
 
-	if (pr->flags.bm_check) {
+	if (pr->flags.bm_check && pr->flags.bm_control) {
 		spin_lock(&c3_lock);
 		/* Enable bus master arbitration */
 		if (c3_cpu_count == num_online_cpus())
