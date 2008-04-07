From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH]correctly use API in acpi idle
Date: Mon, 07 Apr 2008 14:46:21 +0800
Message-ID: <1207550781.24172.2.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16637 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbYDGGpB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2008 02:45:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>

synchronize_sched() can't guarantee all cpus exit idle loop, use correct API

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 788da97..ed12897 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1308,7 +1308,7 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 
 	/* Fall back to the default idle loop */
 	pm_idle = pm_idle_save;
-	synchronize_sched();	/* Relies on interrupts forcing exit from idle. */
+	cpu_idle_wait(); /* Force CPUs exit idle loop */
 
 	pr->flags.power = 0;
 	result = acpi_processor_get_power_info(pr);


