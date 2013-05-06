From: Max Asbock <masbock@linux.vnet.ibm.com>
Subject: [Patch] MCE, APEI: Don't enable CMCI when Firmware First mode is
 set in HEST for corrected machine checks
Date: Mon, 06 May 2013 15:58:22 -0700
Message-ID: <1367881102.4518.68.camel@oc3432500282.ibm.com>
Reply-To: masbock@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:42348 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649Ab3EFW6c (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 May 2013 18:58:32 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <masbock@linux.vnet.ibm.com>;
	Mon, 6 May 2013 16:58:31 -0600
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de
Cc: lkml@vger.kernel.org, linux-acpi@vger.kernel.org, ying.huang@intel.com, naveen.n.rao@in.ibm.com, ananth@in.ibm.com, lcm@linux.vnet.ibm.com

This patch adds code to the machine check handler to parse the 
APEI Hardware Error Source Table (HEST) and check if Firmware First mode
is set for the Correct Machine Check structure in HEST.
If Firmware First mode is set, the corrected machine checks are expected
to be reported through a Generic Hardware Error Source (GHES). Therefore in this
case CMCI will not be enabled to avoid interference with the firmware's
error reporting.

Signed-off-by: Max Asbock <masbock@linux.vnet.ibm.com>
---
 include/asm/mce.h                |    2 +
 kernel/cpu/mcheck/mce-apei.c     |   70 +++++++++++++++++++++++++++++++++++++++
 kernel/cpu/mcheck/mce-internal.h |    5 ++
 kernel/cpu/mcheck/mce_intel.c    |    6 ++-
 4 files changed, 81 insertions(+), 2 deletions(-)


diff -burpN linux-3.9/arch/x86/include/asm/mce.h linux-3.9.ff/arch/x86/include/asm/mce.h
--- linux-3.9/arch/x86/include/asm/mce.h	2013-05-02 09:38:16.000000000 -0700
+++ linux-3.9.ff/arch/x86/include/asm/mce.h	2013-05-03 13:20:36.000000000 -0700
@@ -144,12 +144,14 @@ DECLARE_PER_CPU(struct device *, mce_dev
 
 #ifdef CONFIG_X86_MCE_INTEL
 void mce_intel_feature_init(struct cpuinfo_x86 *c);
+void mce_intel_init_cmci(void);
 void cmci_clear(void);
 void cmci_reenable(void);
 void cmci_rediscover(void);
 void cmci_recheck(void);
 #else
 static inline void mce_intel_feature_init(struct cpuinfo_x86 *c) { }
+static inline void mce_intel_init_cmci(void) {}
 static inline void cmci_clear(void) {}
 static inline void cmci_reenable(void) {}
 static inline void cmci_rediscover(void) {}
diff -burpN linux-3.9/arch/x86/kernel/cpu/mcheck/mce-apei.c linux-3.9.ff/arch/x86/kernel/cpu/mcheck/mce-apei.c
--- linux-3.9/arch/x86/kernel/cpu/mcheck/mce-apei.c	2013-05-02 09:38:16.000000000 -0700
+++ linux-3.9.ff/arch/x86/kernel/cpu/mcheck/mce-apei.c	2013-05-06 14:25:48.000000000 -0700
@@ -32,6 +32,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/cper.h>
+#include <linux/init.h>
 #include <acpi/apei.h>
 #include <asm/mce.h>
 
@@ -148,3 +149,72 @@ int apei_clear_mce(u64 record_id)
 {
 	return erst_clear(record_id);
 }
+
+
+/* Support for Firmware First (FF) mode for Corrected Machine Checks
+ * as defined by APEI in the Hardware Error Source Table (HEST).
+ * (see section 18.3.2.2 in the ACPI spec, version 5.0)
+ *
+ * When Firmware First mode is specified in HEST for Corrected Machine Checks,
+ * these errors are expected to be reported by the firmware through a
+ * Generic Harware Event Source (GHES). In this case error reporting
+ * through CMCI should not be enabled so it won't interfere with the firmware.
+ *
+ * In the boot sequence HEST parsing is initialized after
+ * CPUs, therefore initially we don't know if Firmware First is set.
+ * We just assume yes, and enable CMCI in a late init call if FF is not set.
+ */
+static bool cmc_firmware_first;
+static bool cmc_firmware_first_checked;
+
+bool apei_cmc_firmware_first(void)
+{
+	if (!cmc_firmware_first_checked)
+		return true;
+	return cmc_firmware_first;
+}
+
+static int check_cmc_firmware_first(struct acpi_hest_header *hest_hdr, void *d)
+{
+	if (hest_hdr->type == ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) {
+		struct acpi_hest_ia_corrected *cmc;
+
+		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
+
+		if (cmc->flags & ACPI_HEST_FIRMWARE_FIRST) {
+			cmc_firmware_first = true;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static void intel_late_init_cmci(void *data)
+{
+	if (!mce_available(__this_cpu_ptr(&cpu_info)))
+		return;
+
+	mce_intel_init_cmci();
+}
+
+static __init int honor_cmc_firmware_first(void)
+{
+	struct cpuinfo_x86 *c = __this_cpu_ptr(&cpu_info);
+
+	if (c->x86_vendor != X86_VENDOR_INTEL)
+		return 0;
+
+	apei_hest_parse(check_cmc_firmware_first, NULL);
+	cmc_firmware_first_checked = true;
+
+	if (cmc_firmware_first)
+		mca_cfg.cmci_disabled = true;
+
+	if (mca_cfg.cmci_disabled || mca_cfg.ignore_ce)
+		return 0;
+
+	on_each_cpu(intel_late_init_cmci, NULL, 1);
+	return 0;
+}
+
+late_initcall(honor_cmc_firmware_first);
diff -burpN linux-3.9/arch/x86/kernel/cpu/mcheck/mce_intel.c linux-3.9.ff/arch/x86/kernel/cpu/mcheck/mce_intel.c
--- linux-3.9/arch/x86/kernel/cpu/mcheck/mce_intel.c	2013-05-02 09:38:16.000000000 -0700
+++ linux-3.9.ff/arch/x86/kernel/cpu/mcheck/mce_intel.c	2013-05-03 13:21:53.000000000 -0700
@@ -315,7 +315,7 @@ void cmci_reenable(void)
 		cmci_discover(banks);
 }
 
-static void intel_init_cmci(void)
+void mce_intel_init_cmci(void)
 {
 	int banks;
 
@@ -337,5 +337,7 @@ static void intel_init_cmci(void)
 void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
 	intel_init_thermal(c);
-	intel_init_cmci();
+
+	if (!apei_cmc_firmware_first())
+		mce_intel_init_cmci();
 }
diff -burpN linux-3.9/arch/x86/kernel/cpu/mcheck/mce-internal.h linux-3.9.ff/arch/x86/kernel/cpu/mcheck/mce-internal.h
--- linux-3.9/arch/x86/kernel/cpu/mcheck/mce-internal.h	2013-05-02 09:38:16.000000000 -0700
+++ linux-3.9.ff/arch/x86/kernel/cpu/mcheck/mce-internal.h	2013-05-03 13:20:36.000000000 -0700
@@ -43,6 +43,7 @@ int apei_write_mce(struct mce *m);
 ssize_t apei_read_mce(struct mce *m, u64 *record_id);
 int apei_check_mce(void);
 int apei_clear_mce(u64 record_id);
+bool apei_cmc_firmware_first(void);
 #else
 static inline int apei_write_mce(struct mce *m)
 {
@@ -60,4 +61,8 @@ static inline int apei_clear_mce(u64 rec
 {
 	return -EINVAL;
 }
+static inline bool apei_cmc_firmware_first(void)
+{
+	return 0;
+}
 #endif


