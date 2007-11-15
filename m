From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH_6/7] ACPI: Init PDC before getting throttling info
Date: Thu, 15 Nov 2007 17:05:46 +0800
Message-ID: <1195117546.6817.41.camel@yakui_zhao.sh.intel.com>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
	 <200710092343.40843.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24738 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756343AbXKOIz0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2007 03:55:26 -0500
In-Reply-To: <200710092343.40843.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Init PDC before getting throttling info
>From : Zhao Yakui <yakui.zhao@intel.com>

The throttling info should be obtained after PDC is initialized.
Otherwise the cpus maybe use the different PTC control/status register
when the system supports the TSS throttling via ACPI MSR.
One uses the System I/O mode and the other uses the Fixed HW access mode.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 drivers/acpi/processor_core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.24-rc1/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.24-rc1.orig/drivers/acpi/processor_core.c
+++ linux-2.6.24-rc1/drivers/acpi/processor_core.c
@@ -612,12 +612,6 @@ static int acpi_processor_get_info(struc
 		request_region(pr->throttling.address, 6, "ACPI CPU throttle");
 	}
 
-#ifdef CONFIG_CPU_FREQ
-	acpi_processor_ppc_has_changed(pr);
-#endif
-	acpi_processor_get_throttling_info(pr);
-	acpi_processor_get_limit_info(pr);
-
 	return 0;
 }
 
@@ -665,6 +659,12 @@ static int __cpuinit acpi_processor_star
 	/* _PDC call should be done before doing anything else (if reqd.). */
 	arch_acpi_processor_init_pdc(pr);
 	acpi_processor_set_pdc(pr);
+#ifdef CONFIG_CPU_FREQ
+	acpi_processor_ppc_has_changed(pr);
+#endif
+	acpi_processor_get_throttling_info(pr);
+	acpi_processor_get_limit_info(pr);
+
 
 	acpi_processor_power_init(pr, device);
 
