From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: [PATCH] acpi: pdc init related memory leak with physical CPU hotplug
Date: Fri, 19 Jun 2009 17:14:59 -0700
Message-ID: <20090620001458.GA31429@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:16791 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbZFTAO5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Jun 2009 20:14:57 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Yakui Zhao <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


arch_acpi_processor_cleanup_pdc() in x86 and ia64 results in memory allocated
for _PDC objects that is never freed and will cause memory leak in case of
physical CPU remove and add. Patch fixes the memory leak by freeing the
objects soon after _PDC is evaluated.

Reported-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
---
 arch/ia64/kernel/acpi-processor.c |   12 ++++++++++++
 arch/x86/kernel/acpi/processor.c  |   13 +++++++++++++
 drivers/acpi/processor_core.c     |    2 ++
 include/acpi/processor.h          |    1 +
 4 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/acpi-processor.c b/arch/ia64/kernel/acpi-processor.c
index cbe6cee..dbda7bd 100644
--- a/arch/ia64/kernel/acpi-processor.c
+++ b/arch/ia64/kernel/acpi-processor.c
@@ -71,3 +71,15 @@ void arch_acpi_processor_init_pdc(struct acpi_processor *pr)
 }
 
 EXPORT_SYMBOL(arch_acpi_processor_init_pdc);
+
+void arch_acpi_processor_cleanup_pdc(struct acpi_processor *pr)
+{
+	if (pr->pdc) {
+		kfree(pr->pdc->pointer->buffer.pointer);
+		kfree(pr->pdc->pointer);
+		kfree(pr->pdc);
+		pr->pdc = NULL;
+	}
+}
+
+EXPORT_SYMBOL(arch_acpi_processor_cleanup_pdc);
diff --git a/arch/x86/kernel/acpi/processor.c b/arch/x86/kernel/acpi/processor.c
index 7c074ee..d296f4a 100644
--- a/arch/x86/kernel/acpi/processor.c
+++ b/arch/x86/kernel/acpi/processor.c
@@ -72,6 +72,7 @@ static void init_intel_pdc(struct acpi_processor *pr, struct cpuinfo_x86 *c)
 	return;
 }
 
+
 /* Initialize _PDC data based on the CPU vendor */
 void arch_acpi_processor_init_pdc(struct acpi_processor *pr)
 {
@@ -85,3 +86,15 @@ void arch_acpi_processor_init_pdc(struct acpi_processor *pr)
 }
 
 EXPORT_SYMBOL(arch_acpi_processor_init_pdc);
+
+void arch_acpi_processor_cleanup_pdc(struct acpi_processor *pr)
+{
+	if (pr->pdc) {
+		kfree(pr->pdc->pointer->buffer.pointer);
+		kfree(pr->pdc->pointer);
+		kfree(pr->pdc);
+		pr->pdc = NULL;
+	}
+}
+
+EXPORT_SYMBOL(arch_acpi_processor_cleanup_pdc);
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 23f0fb8..d40d45e 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -731,6 +731,8 @@ static int __cpuinit acpi_processor_start(struct acpi_device *device)
 	/* _PDC call should be done before doing anything else (if reqd.). */
 	arch_acpi_processor_init_pdc(pr);
 	acpi_processor_set_pdc(pr);
+	arch_acpi_processor_cleanup_pdc(pr);
+
 #ifdef CONFIG_CPU_FREQ
 	acpi_processor_ppc_has_changed(pr);
 #endif
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 4927c06..baf1e0a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -258,6 +258,7 @@ DECLARE_PER_CPU(struct acpi_processor *, processors);
 extern struct acpi_processor_errata errata;
 
 void arch_acpi_processor_init_pdc(struct acpi_processor *pr);
+void arch_acpi_processor_cleanup_pdc(struct acpi_processor *pr);
 
 #ifdef ARCH_HAS_POWER_INIT
 void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
-- 
1.6.0.6

