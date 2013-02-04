From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH 1/5] numa: avoid export acpi_numa variable
Date: Mon, 4 Feb 2013 16:43:42 +0800
Message-ID: <1359967426-32629-2-git-send-email-lig.fnst@cn.fujitsu.com>
References: <1359967426-32629-1-git-send-email-lig.fnst@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359967426-32629-1-git-send-email-lig.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: liguang <lig.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

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
 arch/x86/include/asm/acpi.h |    3 ++-
 arch/x86/mm/numa.c          |    2 +-
 arch/x86/mm/srat.c          |   10 +++++-----
 arch/x86/xen/enlighten.c    |    2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 0c44630..c4e0875 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -181,7 +181,8 @@ static inline void disable_acpi(void) { }
 #define ARCH_HAS_POWER_INIT	1
 
 #ifdef CONFIG_ACPI_NUMA
-extern int acpi_numa;
+extern void bad_srat(void);
+extern bool srat_disabled(void);
 extern int x86_acpi_numa_init(void);
 #endif /* CONFIG_ACPI_NUMA */
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2d125be..92986d8 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -47,7 +47,7 @@ static __init int numa_setup(char *opt)
 #endif
 #ifdef CONFIG_ACPI_NUMA
 	if (!strncmp(opt, "noacpi", 6))
-		acpi_numa = -1;
+		bad_srat();
 #endif
 	return 0;
 }
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 4ddf497..a837c95 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -24,22 +24,22 @@
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
-int acpi_numa __initdata;
+static bool acpi_numa __initdata;
 
 static __init int setup_node(int pxm)
 {
 	return acpi_map_pxm_to_node(pxm);
 }
 
-static __init void bad_srat(void)
+void __init bad_srat(void)
 {
 	printk(KERN_ERR "SRAT: SRAT not used.\n");
-	acpi_numa = -1;
+	acpi_numa = false;
 }
 
-static __init inline int srat_disabled(void)
+bool __init srat_disabled(void)
 {
-	return acpi_numa < 0;
+	return acpi_numa;
 }
 
 /* Callback for SLIT parsing */
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 138e566..94c8c70 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1415,7 +1415,7 @@ asmlinkage void __init xen_start_kernel(void)
 	 * any NUMA information the kernel tries to get from ACPI will
 	 * be meaningless.  Prevent it from trying.
 	 */
-	acpi_numa = -1;
+	bad_srat();
 #endif
 
 	/* Don't do the full vcpu_info placement stuff until we have a
-- 
1.7.2.5
