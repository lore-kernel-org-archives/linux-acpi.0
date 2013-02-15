From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH v4 2/4] numa: avoid export acpi_numa variable
Date: Fri, 15 Feb 2013 10:23:10 +0800
Message-ID: <1360894992-14818-3-git-send-email-lig.fnst@cn.fujitsu.com>
References: <1360894992-14818-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:56122 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932322Ab3BODMC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Feb 2013 22:12:02 -0500
In-Reply-To: <1360894992-14818-1-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: rientjes@google.com, isimatu.yasuaki@jp.fujitsu.com, liguang <lig.fnst@cn.fujitsu.com>

acpi_numa is used to prevent srat table
being parsed, seems a little miss-named,
if 'noacpi' was specified by cmdline and
CONFIG_ACPI_NUMA was enabled, acpi_numa
will be operated directly from everywhere
it needed to disable/enable numa in acpi
mode which was a bad thing, so, try to
export a fuction to get srat table
enable/disable info.

Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/acpi.h |    2 +-
 arch/x86/kernel/acpi/srat.c |   21 +++++++++++++--------
 arch/x86/mm/numa.c          |    2 +-
 arch/x86/xen/enlighten.c    |    2 +-
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index b31bf97..449e12a 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -177,7 +177,7 @@ static inline void disable_acpi(void) { }
 #define ARCH_HAS_POWER_INIT	1
 
 #ifdef CONFIG_ACPI_NUMA
-extern int acpi_numa;
+extern void disable_acpi_numa(void);
 extern int x86_acpi_numa_init(void);
 #endif /* CONFIG_ACPI_NUMA */
 
diff --git a/arch/x86/kernel/acpi/srat.c b/arch/x86/kernel/acpi/srat.c
index cdd0da9..1b5b461 100644
--- a/arch/x86/kernel/acpi/srat.c
+++ b/arch/x86/kernel/acpi/srat.c
@@ -24,22 +24,27 @@
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
-int acpi_numa __initdata;
+static bool acpi_numa __initdata;
 
 static __init int setup_node(int pxm)
 {
 	return acpi_map_pxm_to_node(pxm);
 }
 
-static __init void bad_srat(void)
+void __init disable_acpi_numa(void)
 {
-	printk(KERN_ERR "SRAT: SRAT not used.\n");
-	acpi_numa = -1;
+	acpi_numa = false;
 }
 
-static __init inline int srat_disabled(void)
+static void __init bad_srat(void)
 {
-	return acpi_numa < 0;
+	disable_acpi_numa();
+	printk(KERN_ERR "SRAT: SRAT will not be used.\n");
+}
+
+static bool __init srat_disabled(void)
+{
+	return acpi_numa == false;
 }
 
 /* Callback for SLIT parsing */
@@ -88,7 +93,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	}
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
-	acpi_numa = 1;
+	acpi_numa = true;
 	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
 	       pxm, apic_id, node);
 }
@@ -130,7 +135,7 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
-	acpi_numa = 1;
+	acpi_numa = true;
 	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u\n",
 	       pxm, apic_id, node);
 }
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 245a4ba..1ebc907 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -47,7 +47,7 @@ static __init int numa_setup(char *opt)
 #endif
 #ifdef CONFIG_ACPI_NUMA
 	if (!strncmp(opt, "noacpi", 6))
-		acpi_numa = -1;
+		disable_acpi_numa();
 #endif
 	return 0;
 }
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 657eca9..3636bc6 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1447,7 +1447,7 @@ asmlinkage void __init xen_start_kernel(void)
 	 * any NUMA information the kernel tries to get from ACPI will
 	 * be meaningless.  Prevent it from trying.
 	 */
-	acpi_numa = -1;
+	disable_acpi_numa();
 #endif
 
 	/* Don't do the full vcpu_info placement stuff until we have a
-- 
1.7.2.5

