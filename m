From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/34] ACPI: processor: introduce arch_has_acpi_pdc
Date: Thu, 24 Dec 2009 01:23:39 -0500
Message-ID: <1d9cb470a755409ce97c3376174b1e234bd20371.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:63917 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbZLXGYQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 01:24:16 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KV50062M8GF3AHF@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 00:24:15 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

arch dependent helper function that tells us if we should attempt to
evaluate _PDC on this machine or not.

The x86 implementation assumes that the CPUs in the machine must be
homogeneous, and that you cannot mix CPUs of different vendors.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/include/asm/acpi.h     |    2 ++
 arch/x86/include/asm/acpi.h      |    7 +++++++
 arch/x86/kernel/acpi/processor.c |    4 +---
 drivers/acpi/processor_pdc.c     |    3 +++
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 91df968..3b78882 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -132,6 +132,8 @@ extern int __devinitdata pxm_to_nid_map[MAX_PXM_DOMAINS];
 extern int __initdata nid_to_pxm_map[MAX_NUMNODES];
 #endif
 
+static inline bool arch_has_acpi_pdc(void) { return true; }
+
 #define acpi_unlazy_tlb(x)
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 60d2b2d..d787e6e 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -142,6 +142,13 @@ static inline unsigned int acpi_processor_cstate_check(unsigned int max_cstate)
 		return max_cstate;
 }
 
+static inline bool arch_has_acpi_pdc(void)
+{
+	struct cpuinfo_x86 *c = &cpu_data(0);
+	return (c->x86_vendor == X86_VENDOR_INTEL ||
+		c->x86_vendor == X86_VENDOR_CENTAUR);
+}
+
 #else /* !CONFIG_ACPI */
 
 #define acpi_lapic 0
diff --git a/arch/x86/kernel/acpi/processor.c b/arch/x86/kernel/acpi/processor.c
index d85d1b2..bcb6efe 100644
--- a/arch/x86/kernel/acpi/processor.c
+++ b/arch/x86/kernel/acpi/processor.c
@@ -79,9 +79,7 @@ void arch_acpi_processor_init_pdc(struct acpi_processor *pr)
 	struct cpuinfo_x86 *c = &cpu_data(pr->id);
 
 	pr->pdc = NULL;
-	if (c->x86_vendor == X86_VENDOR_INTEL ||
-	    c->x86_vendor == X86_VENDOR_CENTAUR)
-		init_intel_pdc(pr, c);
+	init_intel_pdc(pr, c);
 
 	return;
 }
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index b416c32..931e735 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -69,6 +69,9 @@ static int acpi_processor_eval_pdc(struct acpi_processor *pr)
 
 void acpi_processor_set_pdc(struct acpi_processor *pr)
 {
+	if (arch_has_acpi_pdc() == false)
+		return;
+
 	arch_acpi_processor_init_pdc(pr);
 	acpi_processor_eval_pdc(pr);
 	arch_acpi_processor_cleanup_pdc(pr);
-- 
1.6.0.6

